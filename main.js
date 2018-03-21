/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


$(document).ready(
  function (){
    
    $('div[id^="crear"]').click(
      function(event){
        event.preventDefault(); 
        $('div[id^=creacion]').hide();
        $('.creacion').hide();
        var id = $(this).attr("id");
        switch(id){
          case "crearPartida":
            var form = $('#creacionPartida').children("form")[0];
            form.reset();
            $('input[name="idPartida"]').val(-1);
            $('#creacionPartida').show();
            break;
          case "crearJugador":
            $('#borradoJugador').hide();
            var form = $('#creacionJugador').children("form")[0];
            form.reset();
            $('input[name="idJugador"]').val(-1);
            $('#creacionJugador').show();
            break;
          case "crearPersonaje":
            var form = $('#creacionPersonaje').children("form")[0]
            form.reset();
            $('input[name="idPersonaje"]').val(-1);
            $('#creacionPersonaje').show();
            break;
        }
        $('.creacion').show();
        return false;
      }
      
    );
    
    $(".edicionDatos").click(
      function(event){
        event.preventDefault(); 
        var id = $(this).attr("id");
        switch(id){
          case "editarPartida":
            $('input[name=idPartida]').val($(this).attr("data-idPartida"));
            $('input[name=nombrePartida]').val($(this).attr("data-nombre"));
            $('textarea[name=descripcionPartida]').val($(this).attr("data-descp"));
            var director = $(this).attr("data-director");
            $('select[name=directorPartida]').children().each(
              function (){
                if ($(this).text() === director){
                  $(this).attr('selected','selected');
                }
              }
            );
            $('#creacionPartida').show();
            
            break;
          case  "editarPersonaje":
            break;
          case "editarJugador":
            break;
        }
        $('.creacion').show();
        return false;
      }
    );
    
    $('button[type="button"]').click(
      function(event){
        event.preventDefault();
        $(this).parent()[0].reset();
        $('div[id^=creacion]').hide();
        $('.creacion').hide();
      }
    );
    
    $('.addPj').click(
      function(event){
        event.preventDefault();
        $('div[id^=Partida]').hide();
        var idpartida = $(this).attr("data-partida");
        $('input[name=idPartida]').val(idpartida);
        $('#Partida'+idpartida).show();
      }
    );
    
    $('.editPJ').click(
      function(event){
        event.preventDefault();
        $('div[id^=Partida]').hide();
        var pj = $(this).attr("data-pj");
        var jug = $(this).attr("data-jug");
        var posting = $.post("datosPersonaje.jsp", {pj: pj, jug: jug} );
        posting.done(function(data) {
          $('input[name=nombrePersonaje]').val(pj);
          $('input[name=razaPersonaje]').val(data.raza);
          $('input[name=idPersonaje]').val(data.id);
          $('input[name=edadPersonaje]').val(data.edad);
          $('select[name=jugadorPersonaje]').val(data.jugador);
          $('#creacionPersonaje').show();
        });
        $('.creacion').show();
      }
    );

    $('.editJUG').click(
      function(event){
        event.preventDefault();      
        var jug = $(this).attr("data-jug");
        var posting = $.post("datosJugador.jsp", {jug: jug} );
        posting.done(function(data) {
          $('input[name=nombreJugador]').val(jug);
          $('input[name=idJugador]').val(data.id);
          $('input[name=emailJugador]').val(data.email);          
          $('input[name=nickJugador]').val(data.nick);          
          $('#creacionJugador').show();
          $('#borradoJugador').show();
        });
        $('.creacion').show();
      }
    );

    $('#borradoJugador').click(
      function(event){
        event.preventDefault();
        var form = $('#creacionJugador').children("form")[0];
        form.action = "borrarJugador.jsp";
        form.submit();
      }
    );

  }

);