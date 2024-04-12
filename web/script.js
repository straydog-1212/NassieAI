document.addEventListener("DOMContentLoaded", function() {
  // Function to handle sending a message
  function sendMessage(message) {
    var chatbox = document.getElementById("chat");
    var messageElement = document.createElement("div");
    messageElement.textContent = message;
    chatbox.appendChild(messageElement);
  }

  // Function to handle dropdown menu interactions
  function setupDropdown() {
    var dropdowns = document.querySelectorAll(".dropdown");

    dropdowns.forEach(function(dropdown) {
      var dropdownContent = dropdown.querySelector(".dropdown-content");

      dropdown.addEventListener("mouseenter", function() {
        dropdownContent.style.display = "block";
      });

      dropdown.addEventListener("mouseleave", function() {
        dropdownContent.style.display = "none";
      });
    });
  }

  // Example usage of the sendMessage function
  sendMessage("Welcome to the chat!");

  // Setup dropdown menu interactions
  setupDropdown();
});
