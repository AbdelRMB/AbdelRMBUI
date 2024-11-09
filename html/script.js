let currentMenuName = null;
let currentParentMenu = null;

function sendNuiRequest(endpoint, data) {
    fetch(`https://${GetParentResourceName()}/${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    }).catch((error) => {
        console.error(`Erreur lors de l'appel à ${endpoint}:`, error);
    });
}

window.addEventListener('message', function(event) {
    const data = event.data;

    if (data.action === 'openMenu') {
        currentMenuName = data.menuName;
        currentParentMenu = data.parentMenu || null;

        document.getElementById('menuTitle').innerText = data.menuTitle;
        const menuItems = document.getElementById('menuItems');
        menuItems.innerHTML = '';

        data.items.forEach((item, index) => {
            const listItem = document.createElement('li');
            listItem.innerText = item.label;
            listItem.addEventListener('click', () => {
                sendNuiRequest('selectItem', { index: index, menuName: currentMenuName });
            });
            menuItems.appendChild(listItem);
        });

        document.body.style.display = 'block';
    } else if (data.action === 'closeMenu') {
        document.body.style.display = 'none';
        currentMenuName = null;
        currentParentMenu = null;
    }
});
