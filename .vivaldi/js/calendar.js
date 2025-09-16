import { overrideConsole } from "./internal.js";

const console = overrideConsole("calendar");

const updateCalendarEvents = () => {
  const eventElements = document.body.querySelectorAll(
    `#calendar_panel .calendar-grid .calendar-event`,
  );
  console.debug(`updating ${eventElements.length} calendar events`);
  eventElements.forEach((el) => {
    const eventBody = el.querySelector(".cal-event-body");
    if (eventBody.querySelector(".cal-event-location")) {
      console.debug("skipping event, location already added");
      return;
    }

    const title = el.getAttribute("title") ?? "";
    const locationPattern = /NYC - 125 W 25th-.+?\(\d+\)/gi;
    const matches = title.match(locationPattern);

    if (!matches || matches.length === 0) {
      console.debug("skipping event, no location found");
      return;
    }

    const locString = matches.join(", ");
    const locationEl = document.createElement("div");
    locationEl.className = "cal-event-location";
    locationEl.style.fontSize = "0.8em";
    locationEl.innerText = locString;
    eventBody.appendChild(locationEl);
  });
};

const getCalendarBtn = () => {
  return document.body.querySelectorAll(
    `#panels-container .button-toolbar button[name="PanelCalendar"]`,
  )[0];
};

const getCalendarDateElement = () => {
  return document.body.querySelector(
    "#calendar_panel .toolbar .PeriodPicker h1",
  );
};

const watchCalenderDate = () => {
  const calendarDate = getCalendarDateElement();
  if (!calendarDate) {
    console.warn("could not find calendar date element");
    return () => {};
  }
  const calendarDateWatchCfg = {
    childList: true,
    characterData: true,
    subtree: true,
  };
  const calendarDateCb = () => {
    console.debug("detected calendar date change");
    updateCalendarEvents();
  };
  const calendarDateObserver = new MutationObserver(calendarDateCb);
  console.debug("observing calendar date changes");
  calendarDateObserver.observe(calendarDate, calendarDateWatchCfg);
  return () => {
    console.debug("disconnect calendar date observer");
    calendarDateObserver.disconnect();
  };
};

export default {
  run: () => {
    const calendarBtn = getCalendarBtn();
    const calendarBtnWatchCfg = { attributes: true };

    var cleanupCalendarDateObserver = undefined;
    const calendarBtnCb = () => {
      const el = getCalendarBtn();
      if (el.getAttribute("style")?.includes("--activeButton: 1")) {
        console.debug("detected calendar panel button activated");
        updateCalendarEvents();
        cleanupCalendarDateObserver = watchCalenderDate();
      } else {
        if (cleanupCalendarDateObserver) {
          cleanupCalendarDateObserver();
          cleanupCalendarDateObserver = undefined;
        }
      }
    };
    const calendarBtnObserver = new MutationObserver(calendarBtnCb);
    calendarBtnObserver.observe(calendarBtn, calendarBtnWatchCfg);
  },
};
