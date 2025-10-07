import { overrideConsole } from "./internal.js";
import { watchCalendarEvents } from "./calendar-util.js";

const console = overrideConsole("gmeet-link");

const updateCalendarEvent = (el) => {
  const eventHeader = el.querySelector(".cal-event-header");
  if (eventHeader.querySelector(".cal-event-vmeet")) {
    console.debug("skipping event, vmeet link already added");
    return;
  }

  const title = el.getAttribute("title") ?? "";
  const vmeetPattern =
    /(https:\/\/meet\.google\.com\/[a-zA-Z0-9-]+)|(https:\/\/[^\s.]+\.zoom\.\w+\/\w\/\d+)/gi;
  const matches = title.match(vmeetPattern);

  if (!matches || matches.length === 0) {
    console.debug("skipping event, no vmeet link found");
    return;
  }

  const gmeetEl = document.createElement("span");
  gmeetEl.className = "cal-event-vmeet";

  // Create anchor element
  const gmeetLink = matches[0];
  const gmeetAnchor = document.createElement("a");
  gmeetAnchor.href = gmeetLink;
  gmeetAnchor.target = "_blank";
  gmeetAnchor.rel = "noopener noreferrer";
  gmeetAnchor.addEventListener("click", (e) => {
    e.stopPropagation();
  });

  // Create icon
  const gmeetSvg = document.createElementNS(
    "http://www.w3.org/2000/svg",
    "svg",
  );
  gmeetSvg.setAttribute("xmlns", "http://www.w3.org/2000/svg");
  gmeetSvg.setAttribute("width", "16");
  gmeetSvg.setAttribute("height", "16");
  gmeetSvg.setAttribute("viewBox", "0 0 16 16");
  gmeetSvg.innerHTML = `<rect x="1" y="4" width="9" height="8" rx="2" fill="none" stroke-width="1.5"></rect><polygon points="11,6 15,3.5 15,12.5 11,10" fill="none" stroke-width="1.5"></polygon>`;

  gmeetAnchor.appendChild(gmeetSvg);
  gmeetEl.appendChild(gmeetAnchor);

  let eventIcons = eventHeader.querySelector(".cal-event-icons");
  if (!eventIcons) {
    eventIcons = document.createElement("div");
    eventHeader.appendChild(eventIcons);
  }
  eventIcons.appendChild(gmeetEl);
};

export default {
  run: () => {
    watchCalendarEvents(updateCalendarEvent);
  },
};
