// Josh Davis' Phoenix Config
//     Project: https://github.com/kasper/phoenix
//
// Heavily inspired & borrowed from: https://github.com/Keithbsmiley
var modifiers = ["ctrl", "shift"];

//
// Helper Functions
//

var windowToGrid = function (win, x, y, width, height) {
    var screen = win.screen().frameIncludingDockAndMenu();

    win.setFrame({
        x: Math.round(x * screen.width) + screen.x,
        y: Math.round(y * screen.height) + screen.y,
        width: Math.round(width * screen.width),
        height: Math.round(height * screen.height)
    });
};

var toGrid = function (x, y, width, height) {
    windowToGrid(Window.focusedWindow(), x, y, width, height);
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
    var win = Window.focusedWindow();
    var winFrame = win.frame();
    var current = win.screen().frameIncludingDockAndMenu();
    var next = win.screen().nextScreen().frameIncludingDockAndMenu();

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
    return _(this.runningApps()).filter( function( app ) {
        if (app.title() === title) {
            return true;
        }
    });
};


App.focusOrStart = function (title, cmd) {
    var apps = App.allWithTitle(title);
    if (_.isEmpty(apps)) {
        api.launch(title);
        return;
    }

    var windows = _.chain(apps)
    .map(function(x) { return x.allWindows(); })
    .flatten()
    .value();

    activeWindows = _(windows).reject(function(win) { return win.isWindowMinimized();});
    if (_.isEmpty(activeWindows)) {
        api.runCommand('/bin/bash', ['-c', cmd]);
        return;
    }

    activeWindows.forEach(function(win) {
        win.focusWindow();
    });
};

// Rotate current window between monitors
api.bind('s', modifiers, Window.throwWindow);

// Basic monitor keybindings
api.bind('f', modifiers, Window.fullScreen);
api.bind('h', modifiers, Window.leftHalf);
api.bind('l', modifiers, Window.rightHalf);
api.bind('j', modifiers, Window.bottomHalf);
api.bind('k', modifiers, Window.topHalf);

// For vertical monitors
api.bind('p', modifiers, Window.topPart);
api.bind('n', modifiers, Window.bottomPart);

api.bind('space', modifiers, function () { App.focusOrStart('Terminal', 'open -a Terminal $HOME'); });
api.bind('q', modifiers, function () { App.focusOrStart('Finder', 'open -a Finder'); });
