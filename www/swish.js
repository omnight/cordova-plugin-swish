/**
 * Cordova Swish Plugin
 */

var Swish = (function () { 
    
    function Swish() {
    }
    
    Swish.prototype.echo = function (echoValue, successCallback) {
        cordova.exec(successCallback, function () { console.log('Error') }, 'Swish', 'echo', [echoValue]);
    };

	Swish.prototype.isSwishInstalled = function(successCallback) {
		cordova.exec(successCallback, function() { console.log('swish error'); }, 'Swish', 'isSwishInstalled', []);
	}

	Swish.prototype.beginPayment = function(token, successCallback) {
		cordova.exec(successCallback, function() { console.log('swish error'); }, 'Swish', 'beginPayment', [token]);
	}
	
    return Swish;

})();

var template = new Swish();
module.exports = template;