import { overrideConsole } from "./internal.js";
import { watchCalendarEvents } from "./calendar-util.js";

const console = overrideConsole("calendar");

const updateCalendarEvent = (el) => {
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
};

export default {
  run: () => {
    watchCalendarEvents(updateCalendarEvent);
  },
};
