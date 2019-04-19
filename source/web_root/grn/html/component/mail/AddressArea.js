(function(){
    grn.base.namespace("grn.component.mail.AddressArea.Style.Policy");

    function create(addressArea) {
        return {
            addressArea : addressArea,
            addressAreaStyle : addressAreaStyle,
            sizeOfAllAddressees : sizeOfAllAddressees
        };
    }

    function addressAreaStyle() {
        var style = {};
        var size = this.sizeOfAllAddressees();
        if( this.addressArea.width() == 0 ) {
            style.needUpdate = false;
            style.height = "0px";
            return style;
        }

        var rowOfAddressees = parseInt((size.width / (this.addressArea.width()*0.80)));
        style.height = rowOfAddressees * size.height + "px";
        style.needUpdate = true;

        if( rowOfAddressees > 3 ) {
            style.height = "120px";
            return style;
        }
        if( rowOfAddressees < 2 ) {
            style.height = "52px";
            return style;
        }

        return style;
    }

    function sizeOfAllAddressees() {
        var width = 0;
        var height = 38;
        for(var i = 1,l = this.addressArea.children(".bit-box").length; i <= l; i++) {
            width += this.addressArea.children(".bit-box:nth-child(" + i + ")").width();
        }

        return {
            width : width,
            height : height
        };
    }

    grn.component.mail.AddressArea.Style.Policy = {
        create : create
    };
})();

(function(){
    grn.base.namespace("grn.component.mail.AddressArea.Style.Updater");
    function create(addressArea) {
        return {
            addressArea : addressArea,
            update : update
        };
    }

    function update(addressAreaStyle) {
        this.addressArea.css("height", addressAreaStyle.height);
    }

    grn.component.mail.AddressArea.Style.Updater = {
        create : create
    };
})();

(function(){
    grn.base.namespace("grn.component.mail.AddressArea.EventHandler");
    function dispatch(addressArea) {
        var handler =  grn.component.mail.AddressArea.EventHandler.create(addressArea);
        handler.handleEvent();
    }

    function handleEvent() {
        return;
    }

    function create(addressArea) {
        return {
            policy : grn.component.mail.AddressArea.Style.Policy.create(addressArea),
            listener : grn.component.mail.AddressArea.Style.Updater.create(addressArea),
            handleEvent : handleEvent,
            addressArea : addressArea
        };
    }

    grn.component.mail.AddressArea.EventHandler = {
        dispatch : dispatch,
        create : create
    };

})();

