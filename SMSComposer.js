/*
 * SMSComposer plugin for Cordova
 * @author Matias Singers
 * @file smsComposer.js
 */

var exec = require("cordova/exec");

function SMSComposer(){
	
}

SMSComposer.prototype.show = function(recipient, body, successCallback, errorCallback){
	recipient = recipient || '';
	body = body || '';
	successCallback = (typeof successCallback === 'function') ? successCallback : null;
	errorCallback = (typeof errorCallback === 'function') ? errorCallback : null;

	exec(successCallback, errorCallback, "SMSComposer", "showSMSComposer", [recipient, body]);
};

// Instantiate the smsComposer
var smsComposer = new SMSComposer();
module.exports = smsComposer;