# AbdelRMBUI Library

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![Author](https://img.shields.io/badge/author-AbdelRMB-green)

## 🚀 Introduction
The **AbdelRMBUI Library** is a flexible and customizable menu management system for FiveM servers, developed using **Lua** and **Vue.js**. This library helps you easily integrate interactive menus in your FiveM scripts, with support for player information display and financial data and others.

## 🛠️ Features
- Built using **Lua** and **Vue.js** for a seamless integration.
- Supports different menu types including buttons, checkboxes, and lists.
- Includes pre-built submenus for displaying player information and finances (bank, dirty money, cash).
- Highly customizable and easy to extend.

## 📦 Installation

1. **Download** the library and place it into your server’s `resources` directory.
2. Add the following line to your `server.cfg` file:

    ```cfg
    ensure AbdelRMBUI
    ```

## 🚀 Usage

### Importing the Library
To use the AbdelRMBUI library in your client scripts, first import it:

```lua
local Menu = exports['AbdelRMBUI']
```
