import calendar from "./calendar.js";

const registry = [calendar];

function waitForApp() {
  return new Promise((resolve) => {
    const handle = setInterval(() => {
      const el = document.getElementById("app");
      if (el) {
        clearInterval(handle);
        resolve(el);
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
