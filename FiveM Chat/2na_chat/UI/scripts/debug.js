const Debug = {};

Debug.showChat = () => {
  window.postMessage({
    action: "showChat",
    commandList: ["help", "kick", "ban"],
  });
};

Debug.addExampleSuggestion = () => {
  window.postMessage({
    action: "addSuggestion",
    command: "help",
    description: "Example help command",
    args: [
      {
        name: "important",
        description: "Is it really important?",
      },
    ],
  });

  window.postMessage({
    action: "addSuggestion",
    command: "help",
    description: "Example help command",
    args: [
      {
        name: "important",
        description: "Is it really important?",
      },
    ],
  });
};

Debug.addExampleMessage = (msg) => {
  window.postMessage({
    action: "addMessage",
    message: {
      type: "OOC",
      header: "Jack Smith",
      args: [
        msg?.trim()
          ? msg.trim()
          : "We have a problem with a script! Can you please wait for a second?",
      ],
    },
  });
};
