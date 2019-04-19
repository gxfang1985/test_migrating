/**
 * @namespace grn.component.mail.DropDown
 */
(function(){
    grn.base.namespace("grn.component.mail.DropDown");
    /**
     * flip arrowIcon in DropDownButton
     * @param dropDown
     * @param replace
     */
    function flipArrowIcon(dropDown, replace) {
        dropDown.arrowIcon.removeClass(replace.remove);
        dropDown.arrowIcon.addClass(replace.add);
    }

    /**
     * close DropDownItemList by removing class name.
     * @param dropDown
     */
    function closeDropDownList(dropDown) {
        dropDown.dropDownButton.removeClass("mail-dropdownContents-open");
    }

    /**
     * open DropDownItemList by adding class name.
     * @param dropDown
     */
    function openDropDownList(dropDown) {
        dropDown.dropDownButton.addClass("mail-dropdownContents-open");
    }

    /**
     * generate arrowIcon ClassName identified by uqniueAnchor
     * @see grn.component.mail.DropDown.dropDownComponent
     * @param dropDownComponent
     * @return {Object}
     */
    function arrowIconClass(dropDownComponent) {
        var uniqueAnchor = dropDownComponent.uniqueAnchor;
        var arrowIconClass = {};
        if(uniqueAnchor.is("[id]") && uniqueAnchor.attr("id") == 'stid') {
            arrowIconClass.up = "mail-ButtonStatusArrowUp-grn";
            arrowIconClass.down = "mail-ButtonStatusArrowDown-grn";
            return arrowIconClass;
        }

        arrowIconClass.up = "mail-arrowUp-grn";
        arrowIconClass.down = "mail-arrowDown-grn";
        return arrowIconClass;
    }

    /**
     * create object Drop Down Item Menu List.
     * @param listButton
     * @return {Object}
     */
    function dropDownComponent(listButton) {
        return {
            'dropDownButton' : listButton,
            'uniqueAnchor' : listButton.children().eq(0),
            'arrowIcon' : listButton.children().eq(0).children().eq(0)
        };
    }

    /**
     * @see grn.component.mail.DropDown.dropDownComponent
     * @param dropDownComponent
     */
    function displayDropDown(dropDownComponent) {
        var arrowIcon = this.arrowIconClass(dropDownComponent);
        this.openDropDownList(dropDownComponent);
        this.flipArrowIcon(dropDownComponent, {
           remove : arrowIcon.down,
           add : arrowIcon.up
        });
        this.resizeDropDown(dropDownComponent);
        this.displayDropDownListMenu(dropDownComponent.uniqueAnchor);
    }

    /**
     * @see grn.component.mail.DropDown.dropDownComponent
     * @param dropDownComponent
     */
    function closeDropDown(dropDownComponent) {
        var arrowIcon = this.arrowIconClass(dropDownComponent);
        this.closeDropDownList(dropDownComponent);
        this.flipArrowIcon(dropDownComponent, {
           remove : arrowIcon.up,
           add : arrowIcon.down
        });
    }

    /**
     * returns true when fired Element is drop down button
     * when user have some account, stid would be stid1, stid2,,,
     * So, We must check id by indexOf mehod.
     * @param firedElement
     * @return {Boolean}
     */
    function isClicked(firedElement) {
        if (!firedElement.is("[id]")) {
            return false;
        }

        if (firedElement.is("[id*='stid']")) {
            return true;
        }

        if (firedElement.is("[id*='csid']")) {
            return true;
        }

        return firedElement.is("[id*='dcid']");
    }

    /**
     * check dropDownComponent displayed
     * @see grn.component.mail.DropDown.dropDownComponent
     * @param dropDownComponent
     * @return {Boolean}
     */
    function isDisplayed(dropDownComponent) {
        return dropDownComponent.dropDownButton.hasClass("mail-dropdownContents-open");
    }

    /**
     * @see grn.component.mail.DropDown.dropDownComponent
     * @param dropDownComponent
     */
    function flipDropDown(dropDownComponent) {
        if (this.isDisplayed(dropDownComponent)) {
            this.closeDropDown(dropDownComponent);
            return;
        }
        this.displayDropDown(dropDownComponent);
    }

    /**
     * @see grn.component.mail.DropDown.dropDownComponent
     * @param dropDownComponent
     */
    function resizeDropDown(dropDownComponent) {
        var uniqueAnchor = dropDownComponent.uniqueAnchor;
        var id_name = uniqueAnchor.attr("id") + "_hide_list_menu";
        var div_tag = uniqueAnchor.next();

        if( jQuery("#" + id_name).length <= 0)
        {
            var el = document.createElement('div');
            el.id = id_name;
            el.innerHTML = "&nbsp;";
            el.style.height = '0';
            el.style.width = uniqueAnchor.width() - 2 + 'px';
            div_tag.prepend(el);
        }
    }

    /**
     * @param uniqueAnchor
     */
    function displayDropDownListMenu(uniqueAnchor) {
        var div_tag = uniqueAnchor.next();
        var switchOffset = cumulativeOffset(uniqueAnchor.get(0));

        var left = switchOffset[0] + 1 + "px";
        var top = switchOffset[1] + 22 + "px";
        div_tag.css({top: top, left: left});
    }

    /**
     * handling click event
     * @param event
     */
    function handleEvent(event) {
        var target = jQuery(event.target);
        var dropDown = grn.component.mail.DropDown;
        var dropDownComponentCreator = dropDown.dropDownComponent;
        if(!event.target.id)
        {
            target = target.parent();
        }

        /**
         * close opend dropdown menu list if menu is not clicked.
         **/
        var drop_down = jQuery("span.mail-dropdownContents-open");
        drop_down.each(function () {
            var dropDownComponent = dropDownComponentCreator(jQuery(this));
            if (dropDown.isClicked(target)) {
                return;
            }
            dropDown.closeDropDown(dropDownComponent);
        });

        /**
         * validatiton for dropDown.dropDownComponent
         **/
        if( target.parent().length <= 0 || target.children().eq(0).length <= 0 ) {
            return;
        }

        var tmp_target = target.parent();
        if( tmp_target.hasClass("mail-listButtonDisable-grn"))
        {
            return;
        }

        /**
         * flip clicked drop down menu list.
         **/
        var dropDownComponent = dropDownComponentCreator(target.parent());
        if(dropDown.isClicked(target)) {
            dropDown.flipDropDown(dropDownComponent);
        }
    }

    grn.component.mail.DropDown = {
        flipArrowIcon : flipArrowIcon,
        openDropDownList : openDropDownList,
        closeDropDownList : closeDropDownList,
        arrowIconClass : arrowIconClass,
        dropDownComponent : dropDownComponent,
        closeDropDown : closeDropDown,
        displayDropDown : displayDropDown,
        resizeDropDown :resizeDropDown,
        isClicked : isClicked,
        isDisplayed : isDisplayed,
        displayDropDownListMenu : displayDropDownListMenu,
        flipDropDown : flipDropDown,
        handleEvent : handleEvent
    };
})();
