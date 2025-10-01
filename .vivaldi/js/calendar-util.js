import { overrideConsole } from "./internal.js";

const console = overrideConsole("calendar-util");

/**
 * Watches for new calendar events and calls the callback with the event element
 * each time the calendar page changes.
 * */
export function watchCalendarEvents(cb) {
  const calendarBtn = getCalendarBtn();
  const calendarBtnWatchCfg = { attributes: true };

  var cleanupCalendarDateObserver = undefined;

  if (calendarBtn?.getAttribute("style")?.includes("--activeButton: 1")) {
    cleanupCalendarDateObserver = onCalendarPanelActive(cb);
  }

  const calendarBtnCb = () => {
    const el = getCalendarBtn();
    if (el?.getAttribute("style")?.includes("--activeButton: 1")) {
      cleanupCalendarDateObserver = onCalendarPanelActive(cb);
    } else {
      if (cleanupCalendarDateObserver) {
        cleanupCalendarDateObserver();
        cleanupCalendarDateObserver = undefined;
      }
    }
  };
  const calendarBtnObserver = new MutationObserver(calendarBtnCb);
  calendarBtnObserver.observe(calendarBtn, calendarBtnWatchCfg);
}

const onCalendarPanelActive = (cb) => {
  console.debug("detected calendar panel button activated");
  forEachCalendarEvent(cb);
  return watchCalenderDate(cb);
};

const forEachCalendarEvent = (cb) => {
  const eventElements = document.body.querySelectorAll(
    `#calendar_panel .calendar-grid .calendar-event`,
  );
  eventElements?.forEach((eventEl) => cb(eventEl));
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

const watchCalenderDate = (cb) => {
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
    forEachCalendarEvent(cb);
  };
  const calendarDateObserver = new MutationObserver(calendarDateCb);
  console.debug("observing calendar date changes");
  calendarDateObserver.observe(calendarDate, calendarDateWatchCfg);
  return () => {
    console.debug("disconnect calendar date observer");
    calendarDateObserver.disconnect();
  };
};
