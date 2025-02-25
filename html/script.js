let selectedIndex = 0;

window.addEventListener("message", function (event) {
    if (!event.data || !event.data.type) {
        console.warn("⚠ Événement reçu sans `data.type`, ignoré :", event);
        return;
    }

    if (event.data.type === "openMenu") {

        let menuContainer = document.getElementById("menuContainer");
        let buttonsContainer = document.getElementById("menuButtons");

        menuContainer.style.visibility = "visible";
        menuContainer.style.opacity = "1";
        buttonsContainer.innerHTML = "";

        selectedIndex = 0;

        event.data.buttons.forEach((button, index) => {
            let btn = null;  // Initialise btn comme null

            if (typeof button === "string") {
                btn = document.createElement("button");
                btn.innerText = button;
                btn.classList.add("menu-button", "menu-item");
                if (index === 0) btn.classList.add("selected");
            } else if (button.type === "checkbox") {
                btn = document.createElement("label");
                btn.classList.add("menu-item", "checkbox");
                btn.innerHTML = `<span>${button.label}</span> <input type="checkbox" id="cb${index}" ${button.state ? "checked" : ""}>`;
            } else if (button.type === "slider") {
                btn = document.createElement("input");
                btn.type = "range";
                btn.min = button.min;
                btn.max = button.max;
                btn.value = button.value;
                btn.step = button.step;
                btn.id = `slider${index}`;
                btn.classList.add("menu-item", "slider");
                btn.setAttribute("aria-label", button.label);
                btn.disabled = true;
            } else if (button.type === "list") {
                btn = document.createElement("select");
                btn.id = `list${index}`;
                btn.classList.add("menu-item", "select");
                btn.disabled = true;

                button.options.forEach(opt => {
                    let option = document.createElement("option");
                    option.text = opt;
                    btn.add(option);
                });

                btn.setAttribute("aria-label", button.label);
            } else if (button.type === "input") {
                btn = document.createElement("input");
                btn.type = "text";
                btn.id = `input${index}`;
                btn.value = button.text;
                btn.classList.add("menu-item", "input");
                btn.setAttribute("aria-label", button.label);
                btn.disabled = true;
            }

            // ✅ Vérification avant d'ajouter l'élément
            if (btn !== null) {
                buttonsContainer.appendChild(btn);
            } else {
                console.warn(`⚠ Échec de la création du bouton à l'index ${index} :`, button);
            }
        });


        fetch(`https://${GetParentResourceName()}/setNuiFocus`, {
            method: "POST",
            body: JSON.stringify({ focus: true, cursor: false }),
            headers: { "Content-Type": "application/json" }
        });
    }

    if (event.data.type === "closeMenu") {
        closeMenu();
    }
});


document.addEventListener("keydown", function (event) {
    let items = document.querySelectorAll(".menu-item");
    if (items.length === 0) return;

    let activeElement = document.activeElement;

    if (activeElement.tagName === "INPUT" || activeElement.tagName === "SELECT") {
        if (event.key === "Enter" || event.key === "Backspace") {

            activeElement.disabled = true;
            activeElement.blur();

            return;
        }
        return;
    }

    items[selectedIndex].classList.remove("selected");

    if (event.key === "ArrowUp") {
        selectedIndex = (selectedIndex - 1 + items.length) % items.length;
    }
    else if (event.key === "ArrowDown") {
        selectedIndex = (selectedIndex + 1) % items.length;
    }

    items[selectedIndex].classList.add("selected");

    let selectedItem = items[selectedIndex];

    if (event.key === "Enter") {
        let selectedOption = selectedItem.innerText || selectedItem.value;

        if (selectedItem.classList.contains("checkbox")) {
            let checkbox = selectedItem.querySelector("input[type='checkbox']");
            checkbox.checked = !checkbox.checked;
        }
        if (selectedItem.tagName === "BUTTON") {
            fetch(`https://${GetParentResourceName()}/selectButton`, {
                method: "POST",
                body: JSON.stringify({ menuId: "menu_test", index: selectedIndex + 1 }),
                headers: { "Content-Type": "application/json" }
            });
        }
        else if (selectedItem.tagName === "INPUT" || selectedItem.tagName === "SELECT") {
            selectedItem.disabled = false;
            selectedItem.focus();
        }
    }

    else if (event.key === "Backspace") {
        closeMenu();
    }
});


function closeMenu() {
    let menuContainer = document.getElementById("menuContainer");

    if (!menuContainer) {
        console.warn("⚠ Impossible de fermer le menu, `menuContainer` non trouvé.");
        return;
    }

    menuContainer.style.visibility = "hidden";
    menuContainer.style.opacity = "0";

    fetch(`https://${GetParentResourceName()}/setNuiFocus`, {
        method: "POST",
        body: JSON.stringify({ focus: false, cursor: false }),
        headers: { "Content-Type": "application/json" }
    });

    fetch(`https://${GetParentResourceName()}/closeMenu`, {
        method: "POST",
        headers: { "Content-Type": "application/json" }
    });
}



window.addEventListener("message", function (event) {
    if (event.data.type === "closeMenu") {
        closeMenu();
    }
});
