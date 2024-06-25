let notificationsEnabled = true;
let showingEmojiMenu = false;
let showingChatInput = false;
let enableEmojiMenu = true;
let oocMessageWithoutCommand = false;
let boxTimeout = null;
let showingUsedCommand = 0;
let commandList = [];
let commandSugestions = [];
let usedCommands = [];
let defaultSuggestions = [];
const messages = [];
const suggestionTemplate = `<div data-id="$id" onclick="suggestionClicked('$id')" style="background-color: $color; color: white;" class="suggestion">$content</div>`;
const messageTemplate = `
    <div class="message">
        <div class="message-top">
            <div class="message-top-left">
              <div style="background-color: $typeColor" class="message-type">$type</div>
              <div class="message-header">$header</div>
            </div>
            <div class="message-time">$time</div>
        </div>
        <div class="message-bottom">
            $content
        </div>
    </div
`;

const getTime = () => {
  let date = new Date();
  let hour =
    date.getHours().toString().length == 1
      ? `0${date.getHours()}`
      : date.getHours();
  let minute =
    date.getMinutes().toString().length == 1
      ? `0${date.getMinutes()}`
      : date.getMinutes();

  return `${hour}:${minute}`;
};

const parseText = (str) => {
  return str
    .replace(/(<([^>]+)>)/gi, "")
    .replace(
      /\^([0-9])/g,
      (str, color) => `</span><span class="chat-textColor-${color}">`
    )
    .replaceAll("\n", "<br/>");
};

const addMessage = (type, typeColor, header, content, time) => {
  time = time || getTime();

  $(".message-box").append(
    messageTemplate
      .replaceAll("$typeColor", typeColor || "")
      .replaceAll("$type", type)
      .replaceAll("$header", header)
      .replaceAll("$content", parseText(content))
      .replaceAll("$time", time)
  );

  $(".message-box").animate(
    { scrollTop: $(".message-box")?.get(0)?.scrollHeight },
    400
  );

  messages.push({ type, header, content, time });
};

const clearMessages = () => {
  $(".message-box").children().remove();
};

const getSuggestionsOnScreen = () => {
  let suggestions = [];

  $(".suggestions")
    .children()
    .each((i) => {
      const suggestion = $(`.suggestions .suggestion:nth-child(${i + 1})`).attr(
        "data-id"
      );

      if (suggestion) suggestions.push(suggestion);
    });

  return suggestions;
};

const removeSuggestion = (suggestion) => {
  $(".suggestions")
    .children()
    .each((i) => {
      const suggestionId = $(
        `.suggestions .suggestion:nth-child(${i + 1})`
      ).attr("data-id");

      if (suggestionId == suggestion)
        $(`.suggestions .suggestion:nth-child(${i + 1})`).remove();
    });
};

const updateSuggestions = (newSuggestions) => {
  if (showingEmojiMenu) {
    hideSuggestions();
  } else showSuggestions();

  let suggestionsOnScreen = getSuggestionsOnScreen();

  suggestionsOnScreen.forEach((suggestionOnScreen) => {
    let shouldRemove = true;

    for (let i = 0; i < newSuggestions.length; i++) {
      if (newSuggestions[i].command == suggestionOnScreen) shouldRemove = false;
    }

    if (shouldRemove) removeSuggestion(suggestionOnScreen);
  });

  newSuggestions.forEach((newSuggestion) => {
    let shouldAdd = true;

    for (let i = 0; i < suggestionsOnScreen.length; i++) {
      if (suggestionsOnScreen[i] == newSuggestion.command) shouldAdd = false;
    }

    if (shouldAdd)
      $(".suggestions").append(
        suggestionTemplate
          .replaceAll("$id", newSuggestion.command)
          .replaceAll("$content", newSuggestion.command)
          .replaceAll("$color", newSuggestion.color || "#")
      );
  });
};

const suggestionClicked = (suggestion) => {
  const commandSuggestion = commandSugestions.find(
    (x) => x.command == suggestion
  );

  if (commandSuggestion) {
    let text = `/${suggestion}`;

    commandSuggestion.args.forEach((arg) => {
      text += ` ${arg.name}`;
    });

    $("#chat-text-input").val(text);
  } else {
    $("#chat-text-input").val(`/${suggestion}`);
  }

  $("#chat-text-input").trigger("input");
};

const onTextInput = () => {
  const inputValue = $("#chat-text-input").val().trim();
  const suggestions = [];

  if (inputValue.slice(1).length == 0 || !inputValue.startsWith("/"))
    return updateSuggestions(defaultSuggestions);

  commandList.forEach((command) => {
    if (
      command.startsWith(inputValue.slice(1)) &&
      suggestions.filter((x) => x.command == command).length == 0
    ) {
      suggestions.push({
        command: command,
        color: "gray",
      });
    }
  });

  updateSuggestions(suggestions.slice(0, 10));
};

const showSuggestions = () => {
  if (showingEmojiMenu) return;

  $(".suggestions").css("visibility", "visible");
};
const hideSuggestions = () => {
  $(".suggestions").css("visibility", "hidden");
};

const showChatInput = (focus) => {
  showingChatInput = true;
  $("#chat-text-input").val("");
  $(".chat-input-part").css("display", "flex");
  if (focus) $("#chat-text-input").focus();
  showSuggestions();
  updateSuggestions(defaultSuggestions);
};

const hideChatInput = () => {
  $(".chat-input-part").css("display", "none");
  hideSuggestions();
  showingChatInput = false;
};

const showChatBox = () => {
  $(".message-box").css("visibility", "visible");
};

const hideChatBox = () => {
  $(".message-box").animate({ opacity: 0 }, 250, () => {
    $(".message-box").css("visibility", "hidden");
    $(".message-box").css("opacity", "");
  });
};

const showUsedCommands = (forward) => {
  if (usedCommands.length > 0) {
    if (forward) showingUsedCommand--;
    else showingUsedCommand++;

    if (showingUsedCommand < 0) showingUsedCommand = usedCommands.length - 1;
    else if (showingUsedCommand >= usedCommands.length) showingUsedCommand = 0;

    $("#chat-text-input").focus().val(usedCommands[showingUsedCommand]);
    $("#chat-text-ipnut").trigger("input");
  }
};

const processInput = () => {
  const inputValue = $("#chat-text-input").val().trim();

  if (
    !inputValue.startsWith("/") &&
    inputValue.length >= 1 &&
    oocMessageWithoutCommand
  ) {
    $.post(
      `https://${GetParentResourceName()}/processInput`,
      JSON.stringify({
        command: `ooc ${inputValue}`,
      })
    );
    usedCommands.push(inputValue);
    $.post(`https://${GetParentResourceName()}/hide`);
    return;
  }

  if (inputValue.slice(1).length == 0 || !inputValue.startsWith("/")) return;

  $.post(
    `https://${GetParentResourceName()}/processInput`,
    JSON.stringify({ command: inputValue.slice(1) })
  );

  usedCommands.push(`/${inputValue.slice(1)}`);

  $.post(`https://${GetParentResourceName()}/hide`);
};

const loadEmojiMenu = () => {
  if (!enableEmojiMenu) return;
  emojiList.forEach((emoji) => {
    $(".chat-emoji-menu").append(
      `<div class="emoji-menu-emoji" onclick="emojiClicked('${emoji}')">${emoji}<div/>`
    );
  });
};

const showEmojiMenu = () => {
  if (!enableEmojiMenu) return;
  hideSuggestions();
  $(".chat-emoji-menu").css("display", "flex");
  showingEmojiMenu = true;
};

const hideEmojiMenu = () => {
  $(".chat-emoji-menu").css("display", "none");
  showingEmojiMenu = false;
  showSuggestions();
};

const toggleEmojiMenu = () => {
  if ($(".chat-emoji-menu").css("display") == "none") {
    if ($(".chat-emoji-menu").children().length == 0) {
      loadEmojiMenu();
    }

    showEmojiMenu();
  } else hideEmojiMenu();
};

const emojiClicked = (emoji) => {
  const inputValue = $("#chat-text-input").val();

  $("#chat-text-input").val(`${inputValue}${emoji}`);
  $("#chat-text-input").trigger("input");
};

const toggleNotification = () => {
  if (notificationsEnabled) {
    notificationsEnabled = false;
    $("#notification img").attr("src", "img/bell-slash.png");
  } else {
    notificationsEnabled = true;
    $("#notification img").attr("src", "img/bell.png");
  }
};

window.addEventListener("message", ({ data }) => {
  if (!data) return;

  if (data.commandList) commandList = data.commandList;
  if (data.defaultSuggestions) defaultSuggestions = data.defaultSuggestions;
  if (data?.oocMessageWithoutCommand == true) oocMessageWithoutCommand = true;
  else if (data?.oocMessageWithoutCommand == false)
    oocMessageWithoutCommand = false;
  if (data?.enableEmojiMenu == true) {
    enableEmojiMenu = true;
    $(".chat-emoji").css("display", "flex");
  } else if (data?.enableEmojiMenu == false) {
    enableEmojiMenu = false;
    $(".chat-emoji").css("display", "none");
  }

  switch (data.action) {
    case "showChat":
      clearTimeout(boxTimeout);
      showChatInput(true);
      showChatBox();
      break;

    case "hideChat":
      hideChatInput();
      hideEmojiMenu();
      hideSuggestions();
      showingUsedCommand = null;

      boxTimeout = setTimeout(() => {
        if (!showingChatInput) hideChatBox();
      }, 3000);
      break;

    case "addMessage":
      clearTimeout(boxTimeout);
      if (data.message?.toString()?.startsWith("^1command")) {
        data.message = {
          type: data.message.type || "SYSTEM",
          typeColor: "#de4949",
          header: "ERROR",
          args: [
            data.message.replaceAll("^1command.", "").replaceAll("^0", ""),
          ],
          time: getTime(),
        };
      }

      if (data.message?.args?.join(" ")?.length >= 1) {
        addMessage(
          data.message.type || "COMMAND",
          data.message.typeColor,
          data.message.header || "",
          data.message.args.join(" "),
          data.message.time
        );

        if (notificationsEnabled) {
          showChatBox();

          boxTimeout = setTimeout(() => {
            if (!showingChatInput) hideChatBox();
          }, 5000);
        }
      }
      break;

    case "addSuggestion":
      if (
        commandSugestions.filter((x) => x.command == data.command).length == 0
      ) {
        commandSugestions.push({
          command: data.command,
          description: data.description,
          args: data.args,
        });
      }
      break;

    case "clear":
      clearMessages();
      break;
  }
});

window.addEventListener("keydown", ({ key }) => {
  if (key == "Escape") {
    $.post(`https://${GetParentResourceName()}/hide`);
  } else if (key == "Enter") {
    processInput();
  } else if (key == "ArrowUp") {
    showUsedCommands(true);
  } else if (key == "ArrowDown") {
    showUsedCommands(false);
  }
});

$(document).ready(() => {
  $("#chat-text-input").on("input", onTextInput);
  $("#chat-emoji-icon").on("click", toggleEmojiMenu);
  $("#notification").on("click", toggleNotification);
  loadEmojiMenu();
});
