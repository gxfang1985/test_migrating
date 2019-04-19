/**
 * Component for Full Text Search
 */
grn.base.namespace("grn.component.fts");

(function () {
    var G = grn.component.fts;
    var cp, fp;

    G.SORT = {DATE:'DATETIME', SCORE:'SCORE'};

    G.SearchClient = function (successHandler, runBackgroundSearch) {
        this.successHandler_ = successHandler;
        this.runBackgroundSearch_ = runBackgroundSearch;
        this.start_ = this.sortOrder_ = this.dateLower_ = this.dateUpper_ = this.modifier_ = this.fileOnly_ = this.fileType_ = this.language_ = this.target_ = this.messageOnly_ = this.titleFilter_ = null;
        this.apps_ = [];
        this.spaceApps_ = [];
        this.isSQLSearchMode_ = false;
    };

    cp = G.SearchClient.prototype;

    cp.addApp = function(app) {
        this.apps_.push(app);
    };

    cp.setStart = function(start) {
        this.start_ = start;
    };

    cp.setSortOrder = function(sortOrder) {
        this.sortOrder_ = sortOrder;
    };

    cp.setFileOnly = function(fileOnly) {
        this.fileOnly_ = fileOnly;
    };

    cp.setFileType = function(fileType) {
        this.fileType_ = fileType;
    };

    cp.setModifier = function(modifier) {
        this.modifier_ = modifier;
    };

    cp.setDateLower = function(dateLower) {
        dateLower = jQuery.trim(dateLower);
        if ( dateLower ) {
            this.dateLower_ = dateLower;
        }
    };

    cp.setDateUpper = function(dateUpper) {
        dateUpper = jQuery.trim(dateUpper);
        if ( dateUpper ) {
            this.dateUpper_ = dateUpper;
        }
    };

    cp.setSpaceCategoryId = function(spaceCategoryId) {
        this.spaceCategoryId_ = spaceCategoryId;
    };

    cp.setBulletinCategoryId = function(bulletinCategoryId) {
        this.bulletinCategoryId_ = bulletinCategoryId;
    };

    cp.setMessageFolderId = function(messageFolderId) {
        this.messageFolderId_ = messageFolderId;
    };

    cp.setCabinetFolderId = function(cabinetFolderId) {
        this.cabinetFolderId_ = cabinetFolderId;
    };

    cp.setMailFolderId = function(mailFolderId) {
        this.mailFolderId_ = mailFolderId;
    };

    cp.setSearchRange = function(searchRange) {
        this.searchRange_ = searchRange;
    };

    cp.setSpaceId = function(spaceId) {
        this.spaceId_ = spaceId;
    };

    cp.addSpaceApp = function(spaceApp) {
        this.spaceApps_.push(spaceApp);
    };

    cp.setSender = function(sender) {
        this.sender_ = sender;
    };

    cp.setReceiver = function(receiver) {
        this.receiver_ = receiver;
    };

    cp.setAccountId = function(accountId) {
        this.accountId_ = accountId;
    };

    cp.setLanguage = function(language) {
        this.language_ = language;
    };

    cp.setTarget = function(target) {
        this.target_ = target;
    };

    cp.setMessageOnly = function(messageOnly) {
        this.messageOnly_ = messageOnly;
    };

    cp.setTitleFilter = function(titleFilter) {
        this.titleFilter_ = titleFilter;
    };

    cp.setSQLSearchMode = function () {
        this.isSQLSearchMode_ = true;
    };

    cp.makeSearchParam = function(keyword) {
        var data = {"keyword": keyword};
        var apps = this.apps_;
        var start = this.start_;
        var sortOrder = this.sortOrder_;
        var fileOnly = this.fileOnly_;
        var fileType = this.fileType_;
        var modifier = (this.modifier_) ? jQuery.trim(this.modifier_) : null;
        var dateLower = this.dateLower_;
        var dateUpper = this.dateUpper_;
        var spaceCategoryId = this.spaceCategoryId_;
        var bulletinCategoryId = this.bulletinCategoryId_;
        var messageFolderId = this.messageFolderId_;
        var cabinetFolderId = this.cabinetFolderId_;
        var mailFolderId = this.mailFolderId_;
        var searchRange = this.searchRange_;
        var spaceId = this.spaceId_;
        var spaceApps = this.spaceApps_;
        var sender = this.sender_;
        var receiver = this.receiver_;
        var accountId = this.accountId_;
        var language = this.language_;
        var target = this.target_;
        var messageOnly = this.messageOnly_;
        var titleFilter = this.titleFilter_;

        data.apps = apps;
        if ( start !== null ) {
            data.start = start;
        }
        if ( sortOrder !== null ) {
            data.sortOrder = sortOrder;
        }
        if ( fileOnly !== null ) {
            data.fileOnly = fileOnly;
        }
        if ( fileType !== null ) {
            data.fileType = fileType;
        }
        if ( modifier && jQuery.trim(modifier) ) {
            data.modifier = modifier;
        }
        if ( dateLower !== null ) {
            data.dateLower = dateLower;
        }
        if ( dateUpper !== null ) {
            data.dateUpper = dateUpper;
        }
        if ( spaceCategoryId !== null ) {
            data.spaceCategoryId = spaceCategoryId;
        }
        if ( bulletinCategoryId !== null ) {
            data.bulletinCategoryId = bulletinCategoryId;
        }
        if ( messageFolderId !== null ) {
            data.messageFolderId = messageFolderId;
        }
        if ( cabinetFolderId !== null ) {
            data.cabinetFolderId = cabinetFolderId;
        }
        if ( mailFolderId !== null ) {
            data.mailFolderId = mailFolderId;
        }
        if ( searchRange !== null ) {
            data.searchRange = searchRange;
        }
        if ( spaceId !== null ) {
            data.spaceId = spaceId;
        }
        data.spaceApps = spaceApps;
        if ( sender !== null ) {
            data.sender = sender;
        }
        if ( receiver !== null ) {
            data.receiver = receiver;
        }
        if ( accountId !== null ) {
            data.accountId = accountId;
        }
        if ( language !== null ) {
            data.language = language;
        }
        if ( target !== null ) {
            data.target = target;
        }
        if ( messageOnly !== null ) {
            data.messageOnly = messageOnly;
        }
        if ( titleFilter !== null ) {
            data.titleFilter = titleFilter;
        }
        return data;
    };

    cp.search = function(keyword) {

        var data = this.makeSearchParam(keyword);
        var json = JSON.stringify( data );
        var url = this.isSQLSearchMode_ ? "fts/api/sql_search" : "fts/api/search";

        var request = new grn.component.ajax.request(
            {
                grnUrl: url,
                method: "post",
                dataType: "json",
                jsonp: false,
                processData: false,
                data: json
            }
        );
        request.send().done(
            this.successHandler_
        );

        if (!this.isSQLSearchMode_ && this.runBackgroundSearch_) {
            var backgroundRequest = new grn.component.ajax.request(
                {
                    grnUrl: "fts/api/background/search",
                    method: "post",
                    dataType: "json",
                    jsonp: false,
                    processData: false,
                    data: json,
                    grnErrorHandler: null
                }
            );
            setTimeout(function () {
                backgroundRequest.send();
            }, 1000);
        }
    };

    G.SearchForm = function() {
        this.enableModifier_ = true;
        this.enableFileOnly_ = true;
        this.enableTitleFilter_ = true;
        this.enableFilterHandler_ = true;
    };

    fp = G.SearchForm.prototype;

    fp.disableModifier = function() {
        this.enableModifier_ = false;
    };

    fp.disableFileOnly = function() {
        this.enableFileOnly_ = false;
    };

    fp.disableTitleFilter = function() {
        this.enableTitleFilter_ = false;
    };

    fp.disableFilterHander = function() {
        this.enableFilterHandler_ = false;
    };

    fp.onloadSearch = function() {
        if ( !jQuery.trim(this.textElement_.val()) ) {
            this.spinnerElement_.hide();
            this.emptyTextElement_.show();
        } else {
            this.emptyTextElement_.hide();
            this.handleMoreRead();
        }
    };

    fp.init = function (lang, runBackgroundSearch) {
        this.lang_ = lang;
        this.runBackgroundSearch_ = runBackgroundSearch;

        this.formElement_ = jQuery('#search-fts');
        this.textElement_ = jQuery('#searchbox');
        this.dateFromElement_ = jQuery('#search-date-from');
        this.dateToElement_ = jQuery('#search-date-to');
        this.calendarFromElement_ = jQuery('#search-calendar-from');
        this.calendarToElement_ = jQuery('#search-calendar-to');
        this.resultElement_ = jQuery('#search-result');
        this.spinnerElement_ = jQuery('#search-spinner');
        this.emptyTextElement_ = jQuery('#search-empty-text');
        this.noSearchResultElement_ = jQuery('#no-search-result');
        this.searchMoreElement_ = jQuery('#search-more-container');
        this.informationElement_ = jQuery('#search-information-container');
        this.fileOnlyElement_ = jQuery('#search-fileonly');
        this.fileTypeElement_ = jQuery('#search-filetype');
        this.languageElement_ = jQuery('#search-language');
        this.titleFilterElement_ = jQuery('#search-titleFilter');

        this.text_ = this.textElement_.val();

        this.initClient();
        this.onloadSearch();
        this.formElement_.on("submit", this.submitHandler.bind(this));
        this.searchMoreElement_.on("click", this.handleMoreRead.bind(this));
        this.calendarFromElement_.on("click", this.handleCalendarClicked.bind(this, this.dateFromElement_));
        this.calendarToElement_.on("click", this.handleCalendarClicked.bind(this, this.dateToElement_));

        if ( this.fileTypeElement_.length !== 0 && this.fileOnlyElement_.length !== 0 ) {
            this.fileTypeElement_.on("click", this.handleFileTypeClicked.bind(this, this.fileOnlyElement_));
        }
        if ( this.fileOnlyElement_.length !== 0 ) {
            this.fileOnlyElement_.on("click", this.handleFileOnlyClicked.bind(this, this.fileOnlyElement_));
        }
        if ( this.enableFilterHandler_ && this.titleFilterElement_.length !== 0 && this.fileOnlyElement_.length !== 0 && this.fileTypeElement_.length !== 0 ) {
            this.titleFilterElement_.on("click", this.handleFileFilterDisabled.bind(this, this.titleFilterElement_, this.fileOnlyElement_, this.fileTypeElement_));
            this.fileOnlyElement_.on("click", this.handleTitleFilterDisabled.bind(this, this.fileOnlyElement_, this.titleFilterElement_));
            this.fileTypeElement_.on("click", this.titleFilterDisable.bind(this, jQuery('#titlefilter-label'), this.titleFilterElement_));
        }

        grn.closure_proxy.addDatePicker(this.dateFromElement_[0], this.lang_, true);
        grn.closure_proxy.addDatePicker(this.dateToElement_[0], this.lang_, true);
    };

    /**
     * @returns {grn.component.fts.SearchClient}
     */
    fp.createClient = function() {
        return new G.SearchClient(this.successHandler.bind(this), this.runBackgroundSearch_);
    };

    fp.initClient = function() {
        this.client_ = this.createClient();
        this.client_.setDateLower(this.dateFromElement_.val());
        this.client_.setDateUpper(this.dateToElement_.val());
        this.client_.setLanguage(this.languageElement_.val());

        if ( this.fileTypeElement_.length !== 0 ) {
            this.client_.setFileType(this.fileTypeElement_.val());
        }

        if ( jQuery('#sort-date-button').prop( "checked" ) ) {
            this.client_.setSortOrder(G.SORT.DATE);
        }

        if ( this.enableFileOnly_ && this.fileOnlyElement_.length !== 0 ) {
            if ( this.fileOnlyElement_.prop( "checked" )) {
                this.client_.setFileOnly(true);
            }
        }

        if ( this.enableModifier_ ) {
            this.client_.setModifier(jQuery('#search-modifier').val());
        }

        if ( this.enableTitleFilter_ && this.titleFilterElement_.length !== 0 ) {
            if ( this.titleFilterElement_.prop( "checked" ) ) {
                this.client_.setTitleFilter(true);
            }
        }
    };

    fp.submitHandler = function(event) {
        var keyword = jQuery.trim(this.textElement_.val());

        if ( !keyword ) {
            event.preventDefault();
            return false;
        }
    };

    fp.handleMoreRead = function() {
        this.searchMoreElement_.hide();
        this.spinnerElement_.show();
        this.client_.search(this.text_);
    };

    fp.successHandler = function(transport) {
        this.spinnerElement_.hide();

        this.handleResponseData(transport);

        jQuery(document).trigger("grn.component.fts:finished");
    };

    fp.failureHandler = function(transport) {
        this.errorHandler(transport);
    };

    fp.errorHandler = function(transport) {
        this.spinnerElement_.hide();
        grn.component.error_handler.show(transport);
    };

    fp.handleResponseData = function(data) {
        var result = data.result;
        this.handleResponseResult(result);
    };

    fp.setSQLSearchMode = function() {
        this.client_.setSQLSearchMode();
    };

    /**
     * @param {Object} result
     * @param {Array} result.docs
     * @param {boolean} result.continuable
     * @param {boolean} result.limitFlag
     * @param {int} result.numChecked
     */
    fp.handleResponseResult = function(result) {
        var docs = result.docs;

        if ( !result.continuable && docs.length === 0 ) {
            this.noSearchResultElement_.show();
        } else {
            this.appendResponseData(docs);
        }

        result.continuable ? this.searchMoreElement_.show() : this.searchMoreElement_.hide();
        result.limitFlag ? this.informationElement_.show() : this.informationElement_.hide();

        this.client_.setStart(result.numChecked);
    };

    fp.appendResponseData = function(docs) {
        for(var i in docs){
            if(docs.hasOwnProperty(i) && docs[i] != null) {
                this.appendDocument(docs[i]);
            }
        }
    };

    /**
     * @param {Object} doc
     * @param {string} doc.titleIcon
     * @param {string} doc.snippet
     * @param {string} doc.modifiedTime
     */
    fp.appendDocument = function(doc) {
        var resultDiv = document.createElement('div');
        resultDiv.setAttribute('class', "search-listBlock-grn");

        if ( doc.file ) {
            this.appendFile(resultDiv, doc.file);
        } else {
            this.appendMainTitle(resultDiv, doc);
        }

        // if the document is not a file or the searched keyword is not in a file's title, add a summary snippet
        if ( !doc.file || !doc.file.snippetTitle ) {
            this.appendSummary(resultDiv, doc);
        }

        this.appendInfo(resultDiv, doc);

        this.resultElement_[0].appendChild(resultDiv);
    };

    fp.appendMainTitle = function(element, doc) {
        var titleDiv = document.createElement('div');
        titleDiv.setAttribute('class', "search-listTitle-grn");
        var titleA = document.createElement('a');
        titleA.setAttribute('href', doc.url);
        var titleImg = document.createElement('img');
        titleImg.setAttribute('class', "search-listAppIcon-grn");
        titleImg.setAttribute('src', doc.titleIcon);
        var titleSpan = document.createElement('span');
        titleSpan.innerHTML = doc.title;

        titleA.appendChild(titleImg);
        titleA.appendChild(titleSpan);
        titleDiv.appendChild(titleA);

        element.appendChild(titleDiv);
    };

    fp.appendInfoTitle = function(element, doc) {
        var titleDiv = document.createElement('div');
        titleDiv.setAttribute('class', "search-listInfoSub-grn");
        var titleA = document.createElement('a');
        titleA.setAttribute('href', doc.url);
        var titleImg = document.createElement('img');
        titleImg.setAttribute('src', doc.titleIcon);
        titleImg.setAttribute('class', "search-listAppIconSub-grn");
        var titleSpan = document.createElement('span');
        titleSpan.innerHTML = doc.title;

        titleA.appendChild(titleImg);
        titleA.appendChild(titleSpan);
        titleDiv.appendChild(titleA);

        element.appendChild(titleDiv);
    };

    /**
     * @param {Element} element
     * @param {Object} file
     * @param {string} file.iconUrl
     * @param {string} file.downloadUrl
     * @param {string} file.snippetTitle
     * @param {string} file.title
     */
    fp.appendFile = function(element, file) {
        var fileDiv = document.createElement('div');
        fileDiv.setAttribute('class', "search-listTitle-grn");
        var fileImg = document.createElement('img');
        fileImg.setAttribute('src', file.iconUrl);
        fileImg.setAttribute('class', "search-listAttachmentIcon-grn");
        var fileA = document.createElement('a');
        fileA.setAttribute('href', file.downloadUrl);
        fileA.setAttribute('class', "search-listAttachment-grn");
        var fileTitle = file.snippetTitle ? file.snippetTitle : file.title;
        var fileTitleSpan = document.createElement('span');
        fileTitleSpan.setAttribute('class', 'search-result-snippet');
        fileTitleSpan.innerHTML = fileTitle;
        var fileSizeSpan = document.createElement('span');
        fileSizeSpan.setAttribute('class', 'search-listAttachmentSize-grn');
        fileSizeSpan.innerHTML = this.formatSize(file.size);

        fileA.appendChild(fileImg);
        fileA.appendChild(fileTitleSpan);
        fileDiv.appendChild(fileA);
        fileDiv.appendChild(fileSizeSpan);

        element.appendChild(fileDiv);
    };

    fp.appendSummary = function(element, doc) {
        var dataDiv = document.createElement('div');
        dataDiv.setAttribute('class', 'search-listSummary-grn');
        var snippetP = document.createElement('p');
        snippetP.setAttribute('class', 'search-result-snippet');
        snippetP.innerHTML = doc.snippet;

        dataDiv.appendChild(snippetP);

        element.appendChild(dataDiv);
    };

    fp.appendInfo = function(element, doc) {
        var infoDiv = document.createElement('div');
        infoDiv.setAttribute('class', 'search-listSubArea-grn');

        if ( doc.modifier ) {
            this.appendModifierInfo(infoDiv, doc);
        }
        if ( doc.address ) {
            this.appendMailAddressInfo(infoDiv, doc);
        }

        if ( doc.file ) {
            this.appendInfoTitle(infoDiv, doc);
        } else if ( doc.space ) {
            this.appendSpaceInfo(infoDiv, doc.space);
        }

        element.appendChild(infoDiv);
    };

    /**
     * @param {Element} element
     * @param {Object} space
     * @param {string} space.iconUrl
     * @param {string} space.spaceUrl
     */
    fp.appendSpaceInfo = function(element, space) {
        var spaceSpan = document.createElement('span');
        spaceSpan.setAttribute('class', 'search-listInfoSub-grn');
        var spaceIconSpan = document.createElement('span');
        spaceIconSpan.setAttribute('class', 'search-listAppIconSub-grn');
        var spaceIconImg = document.createElement('img');
        spaceIconImg.setAttribute('class', 'search-space-icon');
        spaceIconImg.setAttribute('src', space.iconUrl);
        var spaceA = document.createElement('a');
        spaceA.setAttribute('href', space.spaceUrl);
        var spaceName = space.name;
        var spaceNameSpan = document.createElement('span');
        spaceNameSpan.innerHTML = spaceName;

        spaceA.appendChild(spaceNameSpan);
        spaceIconSpan.appendChild(spaceIconImg);
        spaceSpan.appendChild(spaceIconSpan);
        spaceSpan.appendChild(spaceA);

        element.appendChild(spaceSpan);
    };

    /**
     * @param {Element} element
     * @param {Object} doc
     * @param {string} doc.address.historyUrl
     */
    fp.appendMailAddressInfo = function(element, doc) {
        var addressSpan = document.createElement('span');
        addressSpan.setAttribute('class', 'search-listUserName-grn');
        var addressA = document.createElement('a');
        addressA.setAttribute('href', doc.address.historyUrl);
        var addressName = doc.address.name;
        var addressNameSpan = document.createElement('span');
        addressNameSpan.setAttribute('class', 'search-result-address-name');
        addressNameSpan.innerHTML = addressName;

        addressA.appendChild(addressNameSpan);
        addressSpan.appendChild(addressA);
        this.appendTimeInfo(addressSpan, doc);

        element.appendChild(addressSpan);
    };

    /**
     * @param {Element} element
     * @param {Object} doc
     * @param {string} doc.modifier.displayName
     * @param {string} doc.modifier.profileUrl
     */
    fp.appendModifierInfo = function(element, doc) {
        var nameSpan = document.createElement('span');
        nameSpan.setAttribute('class', 'search-listUserName-grn');

        var nameA;
        if (doc.modifier.profileUrl === 'undefined') {
            nameA = document.createElement('span');
            nameA.innerHTML = doc.modifier.displayName;
        }
        else {
            nameA = document.createElement('a');
            nameA.setAttribute('href', doc.modifier.profileUrl);
            if (!/^javascript:popupWin/.test(doc.modifier.profileUrl)) {
                nameA.setAttribute('target', '_blank');
            }
            nameA.innerHTML = doc.modifier.displayName;
        }

        nameSpan.appendChild(nameA);
        this.appendTimeInfo(nameSpan, doc);
        element.appendChild(nameSpan);
    };

    fp.appendTimeInfo = function(element, doc) {
        var timeSpan = document.createElement('span');
        timeSpan.setAttribute('class', 'search-listUserDate-grn');
        timeSpan.innerHTML = doc.modifiedTime;
        element.appendChild(timeSpan);
    };

    fp.MB = 1048576;
    fp.KB = 1024;

    fp.formatSize = function(fileSize) {
        var size = parseInt(fileSize);
        var ret = 'N/A';
        if ( !size ) {
            return ret;
        }

        if (size > this.MB) {
            ret = Math.round(size / this.MB) + " MB";
        } else if (size > this.KB) {
            ret = Math.round(size / this.KB) + " KB";
        } else {
            ret = size + " byte";
        }

        return ret;
    };

    fp.handleFileTypeClicked = function(checkboxElement) {
        if( !checkboxElement.prop( "checked" ) ) {
            checkboxElement.prop( "checked", true );
        }
    };

    fp.handleFileOnlyClicked = function(checkboxElement) {
        var fileTypeElement_ = jQuery('#search-filetype');
        if( !checkboxElement.prop( "checked" ) ) {
            fileTypeElement_.val('ALL');
        }
    };

    fp.handleCalendarClicked = function(inputElement) {
        GRN_Event.fireEvent(inputElement[0], 'mousedown');
    };

    /**
     * @param {Element} fileOnly
     * @param {Element} titleFilter
     */
    fp.handleTitleFilterDisabled = function(fileOnly, titleFilter) {
        var label = jQuery('#titlefilter-label');
        if( fileOnly.prop( "checked" ) ) {
            this.titleFilterDisable(label, titleFilter);
        } else {
            this.titleFilterEnable(label, titleFilter);
        }
    };

    /**
     * @param {Element} label
     * @param {Element} titleFilter
     */
    fp.titleFilterDisable = function(label, titleFilter) {
        label.addClass('textDisable-grn');
        titleFilter.prop( "disabled", true );
        titleFilter.prop( "checked", false );
    };

    /**
     * @param {Element} label
     * @param {Element} titleFilter
     */
    fp.titleFilterEnable = function(label, titleFilter) {
        label.removeClass('textDisable-grn');
        titleFilter.prop( "disabled", false );
    };

    /**
     * @param {Element} titleFilter
     * @param {Element} fileOnly
     * @param {Element} fileType
     */
    fp.handleFileFilterDisabled = function(titleFilter, fileOnly, fileType) {
        var label = jQuery('#filefilter-label');
        var span = jQuery('#filetype-span');
        if( titleFilter.prop( "checked" ) ) {
            this.fileFilterDisable(label, span, fileOnly, fileType);
        } else {
            this.fileFilterEnable(label, span, fileOnly, fileType);
        }
    };

    /**
     * @param {Element} label
     * @param {Element} span
     * @param {Element} fileOnly
     * @param {Element} fileType
     */
    fp.fileFilterDisable = function(label, span, fileOnly, fileType) {
        label.addClass('textDisable-grn');
        span.removeClass('search-filetypeLabel-grn');
        span.addClass('search-filetypeLabel-disabled-grn');
        fileType.val('ALL');
        fileOnly.prop( "disabled", true );
        fileType.prop( "disabled", true );
    };

    /**
     * @param {Element} label
     * @param {Element} span
     * @param {Element} fileOnly
     * @param {Element} fileType
     */
    fp.fileFilterEnable = function (label, span, fileOnly, fileType) {
        label.removeClass('textDisable-grn');
        span.removeClass('search-filetypeLabel-disabled-grn');
        span.addClass('search-filetypeLabel-grn');
        fileOnly.prop( "disabled", false );
        fileType.prop( "disabled", false );
    };
})();
