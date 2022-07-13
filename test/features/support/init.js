'use strict';

const apickli = require('apickli');
const {Before} = require('@cucumber/cucumber');

Before(function() {
    this.apickli = new apickli.Apickli('https', 'getgeeks-users-ffmeyer.herokuapp.com');
    this.apickli.addRequestHeader('Cache-Control', 'no-cache');
});