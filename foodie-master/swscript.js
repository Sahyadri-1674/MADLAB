// if ("serviceWorker" in navigator) {
//   navigator.serviceWorker
//     .register("./sw1.js")
//     .then((swreg) => {
//       console.log("Service Worker Successfullt registered", swreg.scope);
//     })
//     .catch((err) => {
//       console.log("Service worker not registered", err);
//     });
// }

if ("serviceWorker" in navigator) {
  window.addEventListener("load", () => {
    navigator.serviceWorker
      .register("/sw1.js")
      .then((registration) => {
        console.log(
          "Service Worker registered with scope:",
          registration.scope
        );
      })
      .catch((error) => {
        console.error("Service Worker registration failed:", error);
      });
  });
}

let deferredPrompt;

//  window.addEventListener("beforeinstallprompt", (event) => {
//    // Prevent Chrome 67 and earlier from automatically showing the prompt
//    event.preventDefault();
//    // Stash the event so it can be triggered later
//    deferredPrompt = event;
//    // Update UI to notify the user they can add to home screen
//    showAddToHomeScreenButton();
//  });
function showAddToHomeScreenPopup() {
  const a2hsPopup = document.getElementById("a2hsPopup");
  a2hsPopup.style.display = "block";
}
function hideAddToHomeScreenPopup() {
  const a2hsPopup = document.getElementById("a2hsPopup");
  a2hsPopup.style.display = "none";
}

window.addEventListener("beforeinstallprompt", (event) => {
  // Prevent the browser from automatically showing the A2HS prompt
  event.preventDefault();
  // Store the event for later use
  deferredPrompt = event;
  // Set a timeout to show the A2HS popup after 10 seconds
  setTimeout(() => {
    // Call the function to show the A2HS popup
    showAddToHomeScreenPopup();
  }, 5000);
});

function addToHomeScreen() {
  // Show the prompt
  deferredPrompt.prompt();
  // Wait for the user to respond to the prompt
  deferredPrompt.userChoice.then((choiceResult) => {
    if (choiceResult.outcome === "accepted") {
      console.log("User accepted the A2HS prompt");
      hideAddToHomeScreenPopup();
    } else {
      console.log("User dismissed the A2HS prompt");
      hideAddToHomeScreenPopup();
    }
    deferredPrompt = null;
  });
}
