import calEventRoom from "./cal-event-room.js";
import calEventGmeet from "./gmeet-link.js";

const registry = [calEventRoom, calEventGmeet];

function waitForApp() {
  return new Promise((resolve) => {
    const handle = setInterval(() => {
      const el = document.getElementById("app");
      if (el) {
        // App element loaded, we wait a bit more to ensure everything loads.
        setTimeout(() => {
          clearInterval(handle);
          resolve(el);
        }, 1000);
      }
    }, 1000);
  });
}

async function runHooks() {
  await waitForApp();
  for (const module of registry) {
    module.run();
  }
}

runHooks();
