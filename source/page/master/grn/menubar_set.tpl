{literal}
<script language="JavaScript" type="text/javascript">
<!--

var mbW=250;
var mbO=[],mbP=[],mbA,mbT,mbTf;

function mbSet(m,c) {
if (document.getElementById&&document.createElement) {
    var m=document.getElementById(m);
    m.className=c;
    var e,f,i,j;

    var e=m.firstChild;
    while (e) {
        if (e.tagName=='LI') {
            var div=document.createElement('div');
            while (e.firstChild) {
                div.appendChild(e.firstChild);
            }
            e.appendChild(div);
        }
        e=e.nextSibling;
    }

    e=m.getElementsByTagName('a');
    if (!mbTf) mbTf=new Function('mbHAT();');
    for (i=0;i<e.length;i++) {
        e[i].onmouseout=e[i].onblur=mbTf;
    }

    m=m.getElementsByTagName('ul');
    for (i=0;i<m.length;i++) {
        if (j=m[i].id) {
            mbO[j]=m[i];
            e=m[i].parentNode;
            f=e.parentNode.getAttribute('id');
            if (mbO[f]) {
                mbP[j]=f;
            }
            f=new Function('mbS(\''+j+'\');');
            e=e.getElementsByTagName('a');
            for (c=0;c<e.length;c++) {
                e[c].onmouseover=e[c].onfocus=f;
            }
            mbH(j);
        }
    }
}}

function mbHA() {
    if (mbA) {
        while (mbA) mbH(mbA);
        mbHE('visible');
    }
}

function mbHAT() {
    if (!mbT) mbT=setTimeout('mbHA();', mbW);
}

function mbTC() {
    if (mbT) {
        clearTimeout(mbT);
        mbT=null;
    }
}

function mbS(m) {
    mbTC();
    if (mbA) while (mbA&&m!=mbA&&mbP[m]!=mbA) mbH(mbA);
    else mbHE('hidden');

    mbSH(m,'visible');
    mbA=m;
}

function mbH(m) {
    if (m==mbA) mbA=mbP[m];
    mbSH(m,'hidden');
    mbT=null;
}

function mbSH(m,v) {
    mbO[m].parentNode.firstChild.className=v;
    mbO[m].style.visibility=v;
}

function mbHE(v) {
    mbHEV(v,document.getElementsByTagName('select'));
}

function mbHEV(v,e) {
    for (var i=0;i<e.length;i++) e[i].style.visibility=v;
}

//-->
</script>
<style type="text/css">
#menubar #menu {
    display: none; /* This is to avoid FUSC and is set to blcok on load via javascript. */
}

#menubar ul.mb {
    list-style: none;
    margin: 0;
    padding: 0; 
    width: 30em;
    float: left;
    background: #fff;
}

#menubar ul.mb li {
    float: left;
    display: block;
    list-style: none;   
    padding: 0;
    background-color: #cccc99;  
    width: 7em;
    margin-right: 1px;  
    color: #336699;
}

/* alternate colors for the wording in the first level nav */

#menubar a span.altcolor{
    color: #333;
}

#menubar a:hover span.altcolor, #menubar ul.mb a.visible span.altcolor,
#menubar ul.mb a.hidden:active span.altcolor{
    color:#FF9933;
}

/* first level nav links */

#menubar ul.mb li a{
    display: block;
    /* begin box model hack */
    width: 8.8em !important;
    width: 9.3em;
    width/**/:/**/8.8em;
    padding: 5px 0 5px 5px;
    color: #336699;
    text-decoration: none;
    font-family: Verdana, Geneva, Arial, Helvetica, sans-serif;
    font-size: 0.75em;
    font-weight: bold;
}

#menubar ul.mb li a:hover{
    background: #336699;
    color: #fff;
}

#menubar ul.mb li a:active, #menubar ul.mb a.visible{
    background: #336699; /* #c30 */
    color: #ffffff;
}

/* div for positioning second level nav */

#menubar ul.mb li div {
    position: relative;
}

/* second level nav */

#menubar ul.mb ul {
    position: absolute;
    top: 1.5em;
    margin: 0;
    padding: 0;
    width: 10.5em;
    border-right: 1px solid #fff;
    border-bottom: 1px solid #fff;
    border-left: 1px solid #fff;
}

#menubar ul.mb ul li {
    position: relative;
    float: left;
    margin: 0;  
    padding: 0; 
    background: #336699;        
    width: 10.5em;  
}

#menubar ul.mb ul>li {   
    display: block;
    /* required for opera: */
    float: none;
}

/* separator */

#menubar ul.mb ul li.separator{
    position: relative;
    margin: 0;  
    padding: 0;
    background: #336699;        
    width: 10.5em;
    border-bottom: 1px solid #aaa;
}

/* second level nav links */

#menubar ul.mb ul li.separator a{
    padding: 4px 4px 12px 4px;
}

#menubar ul.mb ul li a{          
    margin: 0;
    padding: 4px 4px 4px 4px; 
    color: #fff;
    font-weight: normal;    
    display: block;
    width: 93% !important;  
}

#menubar ul.mb ul li a:hover{
    color:#FF9933;
}

/* second level nav arrow */

#menubar ul.mb ul li a.hidden{
    width: 93% !important;
    display: block;
    padding: 4px 4px 4px 4px; 
}

#menubar ul.mb ul li a.visible:hover,
#menubar ul.mb ul li a.visible:active,
#menubar ul.mb ul li a.visible {
    width: 93% !important;  
    padding: 4px 4px 4px 4px;
    display: block;
} 

/* third level nav */

#menubar ul.mb ul ul {   
    top: 0.1em !important;
    left: 10.6em;
    margin: 0;
    padding: 0; 
}
</style>
<script language="JavaScript" type="text/javascript">
<!--
mbSet('menu','mb');
document.getElementById('menu').style.display='block';
//-->
</script>
{/literal}
