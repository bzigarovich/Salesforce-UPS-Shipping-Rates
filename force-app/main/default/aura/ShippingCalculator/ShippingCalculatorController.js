({
    // Handles from address change event.
    // @param component reference to this component
    // @param event reference to the event object
    // @param helper reference to the helper methods
    handleFromAddressChange : function(component, event, helper) {
        component.set("v.fromAddress", event.getParams());
    },

    // Handles to address change event.
    // @param component reference to this component
    // @param event reference to the event object
    // @param helper reference to the helper methods
    handleToAddressChange : function(component, event, helper) {
        component.set("v.toAddress", event.getParams());
    },

    // Handles from address change event.
    // @param component reference to this component
    // @param event reference to the event object
    // @param helper reference to the helper methods
    handlePackageChange : function(component, event, helper) {
        component.set("v.package", event.getParams());
    },

    // Handles get rates button click event.
    // @param component reference to this component
    // @param event reference to the event object
    // @param helper reference to the helper methods
    handleGetRates : function(component, event, helper) {
        helper.getRates(component);
    },

    // Handles key down event
    // @param component reference to this component
    // @param event reference to the event object
    // @param helper reference to the helper methods
    handleKeyDown : function(component, event, helper) {
        // Checks for enter key
        if (13 == event.keyCode) {
            helper.getRates(component);
        }
    }
})