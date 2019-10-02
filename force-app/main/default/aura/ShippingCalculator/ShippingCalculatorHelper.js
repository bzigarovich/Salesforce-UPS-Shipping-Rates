({
    // Gets the shipping rates.
    // @param component reference to this component
    getRates : function(component) {
        var isFromValid = component.find("from").isValid();
        var isToValid = component.find("to").isValid();
        var isPackageValid = component.find("package").isValid();

        // Validates the input
        if (isFromValid && isToValid && isPackageValid) {
            var request = {
                "fromAddress": component.get("v.fromAddress"),
                "toAddress": component.get("v.toAddress"),
                "shipItem": component.get("v.package")
            };

            // Gets the shipping rates from the provider
            component.find("shipAPI").getRates(request, component.get("v.provider")).then(result => {
                component.set("v.isLoading", false);
                component.set("v.rateInfo", result);
            }).catch(error => {
                component.set("v.isLoading", false);
                $A.get("e.force:showToast").setParams({
                    "title": "Error",
                    "type": "error",
                    "duration": 10000,
                    "message": error.body.message
                }).fire();
                component.set("v.rateInfo", null);
            });

            component.set("v.isLoading", true);
        }
    }
})