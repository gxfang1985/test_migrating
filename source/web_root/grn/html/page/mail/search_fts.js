grn.base.namespace("grn.page.mail.search_fts");

(function () {
    var G = grn.page.mail.search_fts;
    var ParentSearchForm = grn.component.fts.SearchForm;

    G.SearchForm = function() {};
    G.SearchForm.prototype = jQuery.extend(new ParentSearchForm(), {
        initClient : function() {
            ParentSearchForm.prototype.initClient.apply(this);
            this.client_.addApp('mail');
            this.client_.setSender(jQuery('#search-mail-sender').val());
            this.client_.setReceiver(jQuery('#search-mail-receiver').val());
            this.client_.setAccountId(jQuery('#search-account-id').val());
            this.client_.setMailFolderId(jQuery('#search-folder-id').val());
            if (this.fileOnlyElement_.val() === "1") {
                this.client_.setFileOnly(true);
                this.client_.setMessageOnly(false);
                jQuery('#search-mail-message-link').on("click", this.submitSearchMail.bind(this, this.fileOnlyElement_));
                jQuery('#selectbox').on("change", this.submitSearchMailFile.bind(this, jQuery('#selectbox')));
            } else {
                this.client_.setFileOnly(false);
                this.client_.setMessageOnly(true);
                jQuery(document).on("grn.component.fts:finished", this.determineTableSize.bind(this, jQuery('#search-mail-result-table')));
                jQuery('#dcid1-top').prop( "disabled", true );
                jQuery('#dcid1-bottom').prop( "disabled", true );
                jQuery('#search-mail-file-link').on("click", this.submitSearchMail.bind(this, this.fileOnlyElement_));
                jQuery('#search-mail-checkAll-button-top').on("click", this.checkAlltoggle.bind(this, document.getElementsByName("ids[]")));
                jQuery('#search-mail-checkAll-button-bottom').on("click", this.checkAlltoggle.bind(this, document.getElementsByName("ids[]")));
                jQuery(document).on("grn.component.fts:finished", this.readyCheckbox.bind(this));
                jQuery('#dcid1-top').on("change", this.changeFolder.bind(this, 'top'));
                jQuery('#dcid1-bottom').on("change", this.changeFolder.bind(this, 'bottom'));
                jQuery('#btn_move_multi-top').on("click", this.moveFolder.bind(this, document.forms['search-mail-result-form']));
                jQuery('#btn_move_multi-bottom').on("click", this.moveFolder.bind(this, document.forms['search-mail-result-form']));
                jQuery(window).resize(this.determineTableSize.bind(this, jQuery('#search-mail-result-table')));
            }
        },

        /**
         * @param {Object} doc
         */
        appendDocument : function (doc) {
            if ( this.fileOnlyElement_.val() === "1" ) {
                this.appendDocumentFile(doc);
            } else {
                if( this.resultElement_.children().length === 0 && jQuery('#search-fileonly').val() === "0" ) {
                    this.displayResultArea();
                }
                this.appendDocumentMessage(doc);
            }
        },

        /**
         * @param doc
         */
        appendDocumentFile : function (doc) {
            var resultDiv = document.createElement('div');
            resultDiv.setAttribute('class', "search-listBlock-grn");

            this.appendFile(resultDiv, doc.file);
            // if the document is not a file or the searched keyword is not in a file's title, add a summary snippet
            if ( !doc.file || !doc.file.snippetTitle ) {
                this.appendSummary(resultDiv, doc);
            }
            this.appendInfo(resultDiv, doc);

            this.resultElement_[0].appendChild(resultDiv);
        },

        /**
         * @param {Object} doc
         */
        appendDocumentMessage : function (doc) {
            var resultTable = jQuery('#search-mail-resultTable-body');

            this.appendMain(resultTable[0], doc);
            this.appendMessageSummary(resultTable[0], doc);
        },

        /**
         * @param {Element} element
         * @param {Object} doc
         */
        appendMain : function (element, doc) {
            var newRecord = document.createElement('tr');
            newRecord.setAttribute('class', "linetwo");

            this.appendCheckBox(newRecord, doc);
            this.appendTitle(newRecord, doc);
            this.appendMailMessageAddressInfo(newRecord, doc);
            this.appendDate(newRecord, doc);
            element.appendChild(newRecord);
        },

        /**
         * @param {Element} element
         * @param {Object} doc
         */
        appendCheckBox : function (element, doc) {
            var td_checkbox = document.createElement('td');
            td_checkbox.setAttribute('class', "td-checkbox");
            var mailId = this.getMailId(doc.url);
            var checkbox = document.createElement('input');
            checkbox.setAttribute('type', "checkbox");
            checkbox.setAttribute('name', "ids[]");
            checkbox.setAttribute('value', mailId);

            td_checkbox.appendChild(checkbox);
            element.appendChild(td_checkbox);
        },

        /**
         * @param {Element} element
         * @param {Object} doc
         */
        appendTitle : function(element, doc) {
            var td_title = document.createElement('td');
            td_title.setAttribute('class', "td-title");
            var titleImg = document.createElement('img');
            titleImg.setAttribute('class', "search-listAppIconSub-grn");
            titleImg.setAttribute('src', doc.titleIcon);
            var mailTitleA = document.createElement('a');
            mailTitleA.setAttribute('href', doc.url);
            var titleSpan = document.createElement('span');

            mailTitleA.appendChild(titleImg);
            mailTitleA.innerHTML = doc.title;
            titleSpan.appendChild(mailTitleA);
            td_title.appendChild(titleSpan);
            element.appendChild(td_title);
        },

        /**
         * @param {Element} element
         * @param {Object} doc
         */
        appendMailMessageAddressInfo : function(element, doc) {
            var td_from = document.createElement('td');
            td_from.setAttribute('class', 'td-name');
            var addressSpan = document.createElement('span');

            if( doc.address ) {
                var span_from = document.createElement('a');
                span_from.setAttribute('href', doc.address.historyUrl);
                span_from.innerHTML = doc.address.name;
                addressSpan.appendChild(span_from);
            }
            td_from.appendChild(addressSpan);
            element.appendChild(td_from);
        },

        /**
         * @param {Element} element
         * @param {Object} doc
         */
        appendDate : function(element, doc) {
            var td_date = document.createElement('td');
            td_date.setAttribute('class', 'td-date');
            this.appendTimeInfo(td_date, doc);
            element.appendChild(td_date);
        },

        /**
         * @param {Element} element
         * @param {Object} doc
         */
        appendMessageSummary : function(element, doc) {
            var tr_summary = document.createElement('tr');
            tr_summary.setAttribute('class', 'linetwo');
            var td_blank = document.createElement('td');
            td_blank.setAttribute('class', 'search-listAreaOptionSummary-grn');
            var td_summary = document.createElement('td');
            td_summary.setAttribute('class', 'search-listAreaOptionSummary-grn');
            td_summary.setAttribute('colspan', '3');
            var dataDiv = document.createElement('div');
            dataDiv.setAttribute('class', 'search-listSummary-grn');
            var snippetP = document.createElement('p');
            snippetP.setAttribute('class', 'search-result-snippet');
            snippetP.innerHTML = doc.snippet;

            dataDiv.appendChild(snippetP);
            td_summary.appendChild(dataDiv);
            tr_summary.appendChild(td_blank);
            tr_summary.appendChild(td_summary);
            element.appendChild(tr_summary);
        },

        /**
         * @param {String} url
         */
        getMailId : function (url) {
            var keyPosition = url.lastIndexOf('=');
            var mailId;
            if(keyPosition) {
                mailId = url.substring(keyPosition + 1);
            }
            return mailId;
        },

        displayResultArea : function () {
            var menuList_ = jQuery('#search-mail-result');
            menuList_.removeClass('hidden');
        },

        /**
         * @param {Element} fileOnly
         */
        submitSearchMail : function(fileOnly) {
            if( fileOnly.val() === "1" ) {
                fileOnly.val("0");
                this.fileTypeElement_.val("ALL");
            } else {
                fileOnly.val("1");
            }
            document.forms['search-fts'].submit();
        },

        /**
         * @param {Element} selectbox
         */
        submitSearchMailFile : function(selectbox) {
            this.fileTypeElement_.val(selectbox.val());
            document.forms['search-fts'].submit();
        },

        /**
         * @param {Array} elements
         */
        checkAlltoggle : function(elements) {
            var i;
            var checked = false;
            for (i = 0; i < elements.length; i++) {
                if ( ! elements[i].checked  ) {
                    checked = true;
                }
            }
            for (i = 0; i < elements.length; i++) {
                elements[i].checked = checked;
            }
            this.disableControll();
        },

        /**
         * set Event.observe each checkbox
         */
        readyCheckbox : function () {
            var elements = jQuery("input[name='ids[]']");
            var i;
            for (i = 0; i < elements.length; i++) {
                elements.eq(i).on("click", this.disableControll.bind(this));
            }
        },

        /**
         * if checkboxes which are checked exists, menu parts has got enabled.
         */
        disableControll : function () {
            var moveSelectBoxTop = jQuery('#dcid1-top');
            if( this.isChecked() ) {
                this.enableMenuButton();
                this.handleMoveButton(moveSelectBoxTop);
            } else {
                this.disabledMenuButton();
                this.disableMoveButton();
            }
        },

        /**
         * disable menu parts
         */
        disabledMenuButton : function() {
            var deleteTopButton = jQuery('#btn_delete_multi-top');
            var deleteBottomButton = jQuery('#btn_delete_multi-bottom');
            var moveSelectBoxTop = jQuery('#dcid1-top');
            var moveSelectBoxBottom = jQuery('#dcid1-bottom');

            moveSelectBoxTop.prop( "disabled", true );
            moveSelectBoxBottom.prop( "disabled", true );
            deleteTopButton.removeClass('mail-listButton-grn');
            deleteBottomButton.removeClass('mail-listButton-grn');
            moveSelectBoxTop.removeClass('selectMove-grn');
            moveSelectBoxBottom.removeClass('selectMove-grn');
            deleteTopButton.addClass('mail-listButtonDisable-grn');
            deleteBottomButton.addClass('mail-listButtonDisable-grn');
            moveSelectBoxTop.addClass('selectMove-grn selectMoveDisable-grn');
            moveSelectBoxBottom.addClass('selectMove-grn selectMoveDisable-grn');
        },

        /**
         * enable menu parts
         */
        enableMenuButton : function() {
            var deleteTopButton = jQuery('#btn_delete_multi-top');
            var deleteBottomButton = jQuery('#btn_delete_multi-bottom');
            var moveSelectBoxTop = jQuery('#dcid1-top');
            var moveSelectBoxBottom = jQuery('#dcid1-bottom');

            moveSelectBoxTop.prop( "disabled", false );
            moveSelectBoxBottom.prop( "disabled", false );
            deleteTopButton.removeClass('mail-listButtonDisable-grn');
            deleteBottomButton.removeClass('mail-listButtonDisable-grn');
            moveSelectBoxTop.removeClass('selectMove-grn selectMoveDisable-grn');
            moveSelectBoxBottom.removeClass('selectMove-grn selectMoveDisable-grn');
            deleteTopButton.addClass('mail-listButton-grn');
            deleteBottomButton.addClass('mail-listButton-grn');
            moveSelectBoxTop.addClass('selectMove-grn');
            moveSelectBoxBottom.addClass('selectMove-grn');
        },

        /**
         * move buttons are disabled until selectbox's value become enabled.
         * @param {Element} selectbox
         */
        handleMoveButton : function (selectbox) {
            if ( selectbox.val().length > 0 && selectbox.val() !== '-1' ) {
                this.enableMoveButton();
            } else {
                this.disableMoveButton();
            }
        },

        /**
         * move button become disabled
         */
        disableMoveButton : function () {
            var moveTopButton = jQuery('#btn_move_multi-top');
            var moveBottomButton = jQuery('#btn_move_multi-bottom');
            moveTopButton.removeClass('mail-listButton-grn');
            moveBottomButton.removeClass('mail-listButton-grn');
            moveTopButton.addClass('mail-listButtonDisable-grn');
            moveBottomButton.addClass('mail-listButtonDisable-grn');
        },

        /**
         * move button become enabled
         */
        enableMoveButton : function () {
            var moveTopButton = jQuery('#btn_move_multi-top');
            var moveBottomButton = jQuery('#btn_move_multi-bottom');
            moveTopButton.removeClass('mail-listButtonDisable-grn');
            moveBottomButton.removeClass('mail-listButtonDisable-grn');
            moveTopButton.addClass('mail-listButton-grn');
            moveBottomButton.addClass('mail-listButton-grn');
        },

        /**
         * evaluate if any checkboxes are checked
         */
        isChecked : function () {
            var elements = document.getElementsByName('ids[]');
            var i;
            var checked = false;
            for (i = 0; i < elements.length; i++) {
                if( elements[i].checked ) {
                    checked = true;
                }
            }
            return checked;
        },

        /**
         * both select boxes of folder change to same value
         * @param {String} handle
         */
        changeFolder : function (handle) {
            var moveSelectBoxTop = jQuery('#dcid1-top');
            var moveSelectBoxBottom = jQuery('#dcid1-bottom');
            if ( handle === 'top' ) {
                moveSelectBoxBottom.children("option").each(function() {
                    if ( jQuery(this).val() === moveSelectBoxTop.val() ) {
                        jQuery(this).prop('selected', true);
                    }
                });

                this.handleMoveButton(moveSelectBoxTop);
            } else if ( handle === 'bottom' ) {
                moveSelectBoxTop.children("option").each(function() {
                    if ( jQuery(this).val() === moveSelectBoxBottom.val() ) {
                        jQuery(this).prop('selected', true);
                    }
                });

                this.handleMoveButton(moveSelectBoxBottom);
            }
        },

        /**
         * submit move folder
         * @param {Element} form
         */
        moveFolder : function (form) {
            var value = jQuery('#dcid1-top').val();
            if ( value.length > 0 && value !== '-1' ) {
                if ( this.isChecked() ) {
                    form.cmd.value = 'move';
                    form.submit();
                }
            }
        },

        /**
         * @param {HTMLTableElement} table
         */
        determineTableSize : function (table) {
            var checkboxes = document.getElementsByClassName('td-checkbox');
            var titles = document.getElementsByClassName('td-title');
            var names = document.getElementsByClassName('td-name');
            var dates = document.getElementsByClassName('td-date');
            var checkWidth, titleWidth, nameWidth, dateWidth;

            table[0].style.tableLayout = "auto";
            this.removeStyle(checkboxes);
            this.removeStyle(titles);
            this.removeStyle(names);
            this.removeStyle(dates);
            table[0].style.width = this.getTableMaxSize();
            checkWidth = document.getElementById('search-result-checkbox-th').clientWidth;
            titleWidth = document.getElementById('search-result-title-th').clientWidth;
            nameWidth = document.getElementById('search-result-name-th').clientWidth;
            dateWidth = document.getElementById('search-result-date-th').clientWidth;
            this.setWidthForClass(checkboxes, checkWidth);
            this.setWidthForClass(titles, titleWidth);
            this.setWidthForClass(names, nameWidth);
            this.setWidthForClass(dates, dateWidth);

            table[0].style.tableLayout = "fixed";
            this.setEllipsis(titles);
            this.setEllipsis(names);
        },

        getTableMaxSize : function () {
            return (document.getElementById('search-result-grn').clientWidth - document.getElementsByClassName('search-conditionArea-grn')[0].clientWidth) + "px";
        },

        removeStyle : function (elements) {
            var i;
            for (i = 0; i < elements.length; i++) {
                elements[i].style.cssText = "";
            }
        },

        /**
         * @param {Array} elements
         * @param {Integer} width
         */
        setWidthForClass : function(elements, width) {
            var i;
            for (i = 0; i < elements.length; i++) {
                elements[i].style.width = width + "px";
            }
        },

        /**
         *
         * @param {Array} elements
         * @param {Integer} width
         */
        setWidthForClassInIE : function(elements, width){
            var i;
            for (i = 1; i < elements.length; i++) { // skip title rows
                elements[i].childNodes[0].style.width = width + "px";
            }
        },

        setEllipsis : function (elements) {
            var i;
            for (i = 0; i < elements.length; i++) {
                elements[i].style.overflow = "hidden";
                elements[i].style.whiteSpace = "nowrap";
                elements[i].style.textOverflow = "ellipsis";
                elements[i].style.wordWrap = "normal";
            }
        },
        submitHandler : function(event) {
            var keyword   = jQuery.trim(this.textElement_.val());
            var sender    = jQuery.trim(jQuery('#search-mail-sender').val());
            var receiver  = jQuery.trim(jQuery('#search-mail-receiver').val());
            if( !keyword ) {
                if( !sender && !receiver ) {
                    event.preventDefault();
                    return false;
                }
                this.setSQLSearchMode();
            }
        },
        onloadSearch : function() {
            var keyword   = jQuery.trim(this.textElement_.val());
            var sender = jQuery.trim(jQuery('#search-mail-sender').val());
            var receiver = jQuery.trim(jQuery('#search-mail-receiver').val());
            if ( !keyword && !sender && !receiver ) {
                this.spinnerElement_.hide();
                this.emptyTextElement_.show();
            } else {
                this.emptyTextElement_.hide();
                if (!keyword) {
                    this.setSQLSearchMode();
                }
                this.handleMoreRead();
            }
        }
    });
})();
