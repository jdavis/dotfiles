// Josh Davis' Phoenix Config
//     Project: https://github.com/kasper/phoenix
//     Version: 2.3
//
// Heavily inspired & borrowed from: https://github.com/Keithbsmiley

var keys = [];
var modifiers = ["ctrl", "shift"];

// Preferences
Phoenix.set({
    // Don't show the menubar icon
    'daemon': true,
    'openAtLogin': true
});

//
// Helper Functions
//

var windowToGrid = function (win, x, y, width, height) {
    var screen = win.screen().flippedFrame();

    win.setFrame({
        x: Math.round(x * screen.width) + screen.x,
        y: Math.round(y * screen.height) + screen.y,
        width: Math.round(width * screen.width),
        height: Math.round(height * screen.height)
    });
};

var toGrid = function (x, y, width, height) {
    windowToGrid(Window.focused(), x, y, width, height);
};

//
// Basic positioning
//

Window.fullScreen = function() {
    toGrid(0, 0, 1, 1);
};

Window.leftHalf = function() {
    toGrid(0, 0, 0.5, 1);
};

Window.rightHalf = function() {
    toGrid(0.5, 0, 0.5, 1);
};

Window.bottomHalf = function() {
    toGrid(0, 0.5, 1, 0.5);
};

Window.topHalf = function() {
    toGrid(0, 0, 1, 0.5);
};

//
// Quarter Window Functions
//

Window.topLeft = function() {
    toGrid(0, 0, 0.5, 0.5);
};

Window.bottomLeft = function() {
    toGrid(0, 0.5, 0.5, 0.5);
};

Window.topRight = function() {
    toGrid(0.5, 0, 0.5, 0.5);
};

Window.bottomRight = function() {
    toGrid(0.5, 0.5, 0.5, 0.5);
};

//
// Functions for vertical monitors
//

Window.topPart = function() {
    toGrid(0, 0, 1, 0.25);
};

Window.bottomPart = function() {
    toGrid(0, 0.25, 1, 0.75);
};

//
// Cycle current window across monitors
//

Window.throwWindow = function() {
    var win = Window.focused();
    var winFrame = win.frame();
    var current = win.screen().flippedFrame();
    var next = win.screen().next().flippedFrame();

    // Proportionally place where it should go based on current placement
    var opts = {
        x: next.x + (winFrame.x - current.x) / current.width * next.width,
        y: next.y + (winFrame.y - current.y) / current.height * next.height,
        width: (winFrame.width / current.width) * next.width,
        height: (winFrame.height / current.height) * next.height,
    };

    win.setFrame(opts);
};

//
// Helper functions for launching applications
//

App.allWithTitle = function( title ) {
    return _(this.all()).filter( function( app ) {
        if (app.name() === title) {
            return true;
        }
    });
};

// TODO: Fix this
App.focusOrStart = function (title, cmd) {
    var apps = App.allWithTitle(title);
    if (_.isEmpty(apps)) {
        App.launch(title);
        return;
    }

    var windows = _.chain(apps)
    .map(function(x) { return x.windows(); })
    .flatten()
    .value();

    activeWindows = _(windows).reject(function(win) { return win.isMinimized();});
    if (_.isEmpty(activeWindows)) {
        Task.run('/bin/bash', ['-c', cmd], function() {});
        return;
    }

    /*
    activeWindows.forEach(function(win) {
        win.focus();
    });
    */
};

// Rotate current window between monitors
keys.push(Key.on('s', modifiers, Window.throwWindow));

// Basic monitor keybindings
keys.push(Key.on('f', modifiers, Window.fullScreen));
keys.push(Key.on('h', modifiers, Window.leftHalf));
keys.push(Key.on('l', modifiers, Window.rightHalf));
keys.push(Key.on('j', modifiers, Window.bottomHalf));
keys.push(Key.on('k', modifiers, Window.topHalf));

// For vertical monitors
keys.push(Key.on('p', modifiers, Window.topPart));
keys.push(Key.on('n', modifiers, Window.bottomPart));

keys.push(Key.on('space', modifiers, function () { App.focusOrStart('Terminal', 'open -a Terminal $HOME'); }));
keys.push(Key.on('q', modifiers, function () { App.focusOrStart('Finder', 'open -a Finder'); }));
