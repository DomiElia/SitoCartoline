$(document).ready(function(){

    //funzione per menù laterale a comparsa
    var i = 0;
    $("#ImgMenuMedia").click(function() {
        if(i == 0) {
            $("#menuDiscesa").css({"display": "block"});
            i = 1;
        }
        else {
            $("#menuDiscesa").css({"display": "none"});
            i = 0;
        }
    });

    $("#menuDiscesa").click(function() {
        $("#menuDiscesa").css({"display": "none"});
        i = 0;
    }); 
 

    //funzione per la barra di loading
    $( function() {
        var progressbar = $( "#progressbar" ),
        progressLabel = $( ".progress-label" );

        progressbar.progressbar({
            value: false,
            change: function() {
                progressLabel.text( progressbar.progressbar( "value" ) + "%" );
            },
            complete: function() {
                progressLabel.text( "Complete!" );
                $("#progressbar").css({"display": "none"});
            }
        });

        function progress() {
            var val = progressbar.progressbar( "value" ) || 0;
            progressbar.progressbar( "value", val + 2 );

            if ( val < 99 ) {
                setTimeout( progress, 50 );
            }
        }

        setTimeout( progress, 100 );
    });

    //indici 
    var xobj = new XMLHttpRequest();
    xobj.overrideMimeType("application/json");
    xobj.open('GET','indiceTitolo.json', false);
    xobj.send("");
    var idx = xobj.responseText; 

    var xobj3 = new XMLHttpRequest();
    xobj.open('GET','indiceMittente.json', false);
    xobj.send("");
    var idx2 = xobj.responseText;

    var xobj2 = new XMLHttpRequest();
    xobj.open('GET','indiceLemma.json', false);
    xobj.send("");
    var idx3 = xobj.responseText;

    //ricerca per titolo 

    $('#titolo').click( function() {
    var indice = JSON.parse(idx); 

    $("#project").autocomplete({
        minLength: 0,
        source: indice,
        focus: function( event, ui ) {
        console.log("onfocus", ui)
        $( "#project" ).val( ui.item.value);
        return false;
        },
        select: function( event, ui ) {
        $( "#project" ).val( ui.item.value );
        $( "#project-id" ).val( ui.item.id );
        $( "#project-description" ).html( ui.item.descrizione );

        return false;
        }
    })
    .autocomplete( "instance" )._renderItem = function( ul, item ) {
        return $( "<li>" )
        .append( "<div>" + item.value + "<br>" + item.id + "</div>" )
        .appendTo( ul );
    };
    } );

    //ricerca per mittente 
    $('#mittente').click( function() {
        var indice3 = JSON.parse(idx2);
  
        $("#project").autocomplete({
          minLength: 0,
          source: indice3,
          focus: function( event, ui ) {
            console.log("onfocus", ui)
            $( "#project" ).val( ui.item.value);
            return false;
          },
          select: function( event, ui ) {
            $( "#project" ).val( ui.item.value );
            $( "#project-id" ).val( ui.item.id );
            $( "#project-description" ).html( ui.item.descrizione );
  
            return false;
          }
        })
        .autocomplete( "instance" )._renderItem = function( ul, item ) {
          return $( "<li>" )
            .append( "<div>" + item.value + "<br>" + item.id + "</div>" )
            .appendTo( ul );
        };
      } );

      //ricerca per lemma 
      $('#lemma').click( function() {
        var indice2 = JSON.parse(idx3); 
  
        $("#project").autocomplete({
          minLength: 0,
          source: indice2,
          focus: function( event, ui ) {
            console.log("onfocus", ui)
            $( "#project" ).val( ui.item.value);
            return false;
          },
          select: function( event, ui ) {
            $( "#project" ).val( ui.item.value );
            $( "#project-id" ).val( ui.item.id );
            $( "#project-description" ).html( ui.item.descrizione );
  
            return false;
          }
        })
        .autocomplete( "instance" )._renderItem = function( ul, item ) {
          return $( "<li>" )
            .append( "<div>" + item.value + "<br>" + item.id + "</div>" )
            .appendTo( ul );
        };
      } );

}); 

//funzione per svuotare le pagine
function clean(){
    let sezioni = document.getElementsByClassName("sezione");
    for (let s in sezioni) {
        sezioni[s].innerHTML="";
    }
}

function clean2(){
    let sezioni = document.getElementsByClassName("modal");
    for (let s in sezioni) {
        sezioni[s].innerHTML="";
    }
}

//funzione per resettare la pagina cerca
function clean3(){
    document.getElementById("project-description").innerHTML="";
    document.getElementById("project").value = ""; 
}

//visualizza home
function displayHome(){
    clean();
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/home.sef.json",
        sourceLocation: "corpusTot.xml"
    }, "async");  
}

//visualizza pagina 'le cartoline'
function displayCartoline() {
    clean();
    document.getElementById("cerca").style.display = "none";
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/lecartoline.sef.json",
        sourceLocation: "corpusTot.xml"
}, "async"); 
} 

//visualizza cerca 
function displayCerca() {
    clean();
    clean3(); 
    document.getElementById("cerca").style.display = "block";
}

//visualizza info
function displayInfo() {
    clean();
    document.getElementById("cerca").style.display = "none";
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/info.sef.json",
        sourceLocation: "corpusTot.xml"
    }, "async"); 
}

//visualizza icona immagine
$(function () {
    $( "#infocartolina").dialog({
        autoOpen: false,
        modal: true,
        width: "50%",
        height: "auto",
        show: {
            effect: "blind",
            duration: 500,
          },
          hide: {
            effect: "explode",
            duration: 500
          },
    });   
}); 

function displayImg(el) {
    let id = el.id;
    clean2();
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/infoCartolina.sef.json",
        sourceLocation: "corpusTot.xml", 
        stylesheetParams: {
            "id" : id
        }
    }, "async");
    $("#infocartolina").dialog('open');
}

//visualizza icona tre linee
function displayTesto(id) {
    clean();
    document.getElementById("cerca").style.display = "none";
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/infoTesto.sef.json",
        sourceLocation: "corpusTot.xml", 
        stylesheetParams: {
            "id" : id
         }  
    }, "async"); 
}

//freccia avanti cambio testo
function avantiTesto() {
    document.getElementById("cerca").style.display = "none";
    let id =  $(".open").attr("id"); 
    //estraggo gli ultimi tre caratteri dello stringa e li converto in numero (gli 0 vengono persi)
    let idNum = Number(id.substr(-3, 3));
    //incremento l'id di 1 e ritrasformo in stringa 
    let nextIdNum = String(idNum+1);
    // aggiungo gli 0 davanti finchè non arriva a lunghezzza 3 
    while(nextIdNum.length < 3) {
        nextIdNum = "0" + nextIdNum;
    }

    if (nextIdNum == "228"){
        nextIdNum = "001";
    }

    let nextId = "cartolina_7694-" + nextIdNum;

    displayTesto(nextId);
} 

//freccia indietro cambio testo
function indietroTesto() {
    document.getElementById("cerca").style.display = "none";
    let id =  $(".open").attr("id"); 
    //estraggo gli ultimi tre caratteri dello stringa e li converto in numero (gli 0 vengono persi)
    let idNum = Number(id.substr(-3, 3));
    //decremento l'id di 1 e ritrasformo in stringa 
    let nextIdNum = String(idNum-1);
    // aggiungo gli 0 davanti finchè non arriva a lunghezzza 3 
    while(nextIdNum.length < 3) {
        nextIdNum = "0" + nextIdNum;
    }

    if (idNum == "001"){
        nextIdNum = "227";
    }

    let nextId = "cartolina_7694-" + nextIdNum;

    displayTesto(nextId);
} 


//visualizza icona con graffetta
function displayLink(id) {
    clean();
    document.getElementById("cerca").style.display = "none";
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/infoLink.sef.json",
        sourceLocation: "corpusTot.xml",
        stylesheetParams: {
            "id" : id
         } 
    }, "async"); 
}

//freccia avanti cambio link
function avantiLink() {
    document.getElementById("cerca").style.display = "none";
    let id =  $(".open").attr("id"); 
    //estraggo gli ultimi tre caratteri dello stringa e li converto in numero (gli 0 vengono persi)
    let idNum = Number(id.substr(-3, 3));
    //incremento l'id di 1 e ritrasformo in stringa 
    let nextIdNum = String(idNum+1);
    // aggiungo gli 0 davanti finchè non arriva a lunghezzza 3 
    while(nextIdNum.length < 3) {
        nextIdNum = "0" + nextIdNum;
    }

    if (nextIdNum == "228"){
        nextIdNum = "001";
    }

    let nextId = "cartolina_7694-" + nextIdNum;

    displayLink(nextId);
} 

//freccia indietro cambio testo
function indietroLink() {
    document.getElementById("cerca").style.display = "none";
    let id =  $(".open").attr("id"); 
    //estraggo gli ultimi tre caratteri dello stringa e li converto in numero (gli 0 vengono persi)
    let idNum = Number(id.substr(-3, 3));
    //decremento l'id di 1 e ritrasformo in stringa 
    let nextIdNum = String(idNum-1);
    // aggiungo gli 0 davanti finchè non arriva a lunghezzza 3 
    while(nextIdNum.length < 3) {
        nextIdNum = "0" + nextIdNum;
    }

    if (idNum == "001"){
        nextIdNum = "227";
    }

    let nextId = "cartolina_7694-" + nextIdNum;

    displayLink(nextId);
} 

//visualizza metadati al click della foto 
function displayMeta(id){
    clean();
    document.getElementById("cerca").style.display = "none";
    SaxonJS.transform({
        stylesheetLocation: "xsl-sef/meta.sef.json",
        sourceLocation: "corpusTot.xml",
        stylesheetParams: {
            "id" : id
         }
   }, "async");
}

//freccia avanti cambio visualizzazione metadati 
function avantiMeta() {
    document.getElementById("cerca").style.display = "none";
    let id =  $(".open").attr("id"); 
    //estraggo gli ultimi tre caratteri dello stringa e li converto in numero (gli 0 vengono persi)
    let idNum = Number(id.substr(-3, 3));
    //incremento l'id di 1 e ritrasformo in stringa 
    let nextIdNum = String(idNum+1);
    // aggiungo gli 0 davanti finchè non arriva a lunghezzza 3 
    while(nextIdNum.length < 3) {
        nextIdNum = "0" + nextIdNum;
    }

    if (nextIdNum == "228"){
        nextIdNum = "001";
    }

    let nextId = "cartolina_7694-" + nextIdNum;

    displayMeta(nextId);
} 

//freccia indietro cambio visualizzazione metadati 
function indietroMeta() {
    document.getElementById("cerca").style.display = "none";
    let id =  $(".open").attr("id"); 
    //estraggo gli ultimi tre caratteri dello stringa e li converto in numero (gli 0 vengono persi)
    let idNum = Number(id.substr(-3, 3));
    //decremento l'id di 1 e ritrasformo in stringa 
    let nextIdNum = String(idNum-1);
    // aggiungo gli 0 davanti finchè non arriva a lunghezzza 3 
    while(nextIdNum.length < 3) {
        nextIdNum = "0" + nextIdNum;
    }

    if (idNum == "001"){
        nextIdNum = "227";
    }

    let nextId = "cartolina_7694-" + nextIdNum;

    displayMeta(nextId);
}







  




     