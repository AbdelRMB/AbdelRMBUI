new Vue({
    el: '#app',
    data: {
        isMenuOpen: false,
        currentMenuName: null,
        currentParentMenu: null,
        menuTitle: '',
        items: []
    },
    methods: {
        sendNuiRequest(endpoint, data) {
            fetch(`https://${GetParentResourceName()}/${endpoint}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(data)
            }).catch((error) => {
                console.error(`Erreur lors de l'appel à ${endpoint}:`, error);
            });
        },
        openMenu(data) {
            this.isMenuOpen = true;
            this.currentMenuName = data.menuName;
            this.currentParentMenu = data.parentMenu || null;
            this.menuTitle = data.menuTitle;
            this.items = data.items;
            this.renderMenu();
        },
        closeMenu() {
            this.isMenuOpen = false;
            this.currentMenuName = null;
            this.currentParentMenu = null;
        
            document.getElementById('app').style.display = 'none';
        
            this.sendNuiRequest('closeMenu', {});
        
            fetch(`https://${GetParentResourceName()}/releaseFocus`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            });
        },
        goBackToParentMenu() {
            this.sendNuiRequest('goBackToParentMenu', {
                menuName: this.currentMenuName
            });
        },
        renderMenu() {
            const app = document.getElementById('app');
            app.innerHTML = '';
            app.style.display = 'block';

            const menu = document.createElement('div');
            menu.className = 'menu';

            const menuTitle = document.createElement('h2');
            menuTitle.className = 'menuTitle';
            menuTitle.innerText = this.menuTitle;
            menu.appendChild(menuTitle);

            const menuItems = document.createElement('ul');
            menuItems.className = 'menuItems';
            menuItems.id = 'menuItems';
            
            this.items.forEach((item, index) => {
                if (item.type === 'input') {
                    const inputDiv = document.createElement('div');
                    inputDiv.className = 'menu-item';

                    const label = document.createElement('label');
                    label.innerText = item.label;

                    const input = document.createElement('input');
                    input.type = item.inputType || 'text';
                    input.value = item.defaultText || '';
                    input.dataset.index = index;

                    input.addEventListener('change', (e) => {
                        this.sendNuiRequest('inputChange', {
                            menuName: this.currentMenuName,
                            index: index,
                            value: e.target.value
                        });
                    });

                    inputDiv.appendChild(label);
                    inputDiv.appendChild(input);
                    menuItems.appendChild(inputDiv);
                } else {
                    const listItem = document.createElement('li');
                    listItem.innerText = item.label;
                    listItem.addEventListener('click', () => {
                        this.sendNuiRequest('selectItem', {
                            index: index,
                            menuName: this.currentMenuName
                        });
                    });
                    menuItems.appendChild(listItem);
                }
            });

            if (this.currentParentMenu) {
                print('submenu');
            } else {
                const navButton = document.createElement('li');
                navButton.className = 'navButton';
                navButton.innerText = 'Quitter';
                navButton.addEventListener('click', () => {
                    this.closeMenu();
                });
                menuItems.appendChild(navButton);
            }

            menu.appendChild(menuItems);
            app.appendChild(menu);
        }
    },
    mounted() {
        window.addEventListener('message', (event) => {
            const data = event.data;

            if (data.action === 'openMenu') {
                this.openMenu(data);
            } else if (data.action === 'closeMenu') {
                this.closeMenu();
            }
        });
    }
});