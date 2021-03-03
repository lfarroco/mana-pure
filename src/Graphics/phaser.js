'use strict';

exports.newGame = function (width) {
  return function (height) {
    return function () {
      const config = {
        type: Phaser.AUTO,
        width,
        height,
      };

      const game = new Phaser.Game(config);

      // for debugging
      window.game = game;
      return game;
    };
  };
};

exports.createScene_ = function (game) {
  return function (name) {
    return function (onError, onSuccess) {
      game.scene.add(
        name,
        {
          preload: function () {
            ['backgrounds/sunset'].forEach((str) =>
              this.load.image(str, 'assets/' + str + '.svg')
            );
          },
          create: function () {
            onSuccess(this);
          },
        },
        true
      );
      return function (cancelError, cancelerError, cancelerSuccess) {
        req.cancel(); // cancel the request
        cancelerSuccess(); // invoke the success callback for the canceler
      };
    };
  };
};

exports.addContainer = function (scene) {
  return function (x) {
    return function (y) {
      return function () {
        return scene.add.container(x, y);
      };
    };
  };
};

exports.addImage = function (scene) {
  return function (x) {
    return function (y) {
      return function (texture) {
        return function () {
          return scene.add.image(x, y, texture);
        };
      };
    };
  };
};
