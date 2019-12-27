<%@page import="Utils.Encriptar"%>
<%@taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%
    HttpSession objsesion = request.getSession(false);
    String id_usuario = (String) objsesion.getAttribute("id_usuario");
    String Descripcion_perfil = (String) objsesion.getAttribute("descripcion_perfil");
    if (id_usuario == null) {
        response.sendRedirect("login.jsp");
    } else {
        if (Descripcion_perfil.equals("ADMINISTRADOR")
                || Descripcion_perfil.equals("JEFE")) {

        } else {
            response.sendRedirect("nomina.htm");
        }
    }
%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta http-equiv="X-UA-Compatible" content="ie=edge">
        <title>Agregar Nuevo Usuario</title>
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" />
        <link rel="stylesheet" href="<c:url value="/Resources/CSS/style.css"/>"/>
        <script src="https://kit.fontawesome.com/a076d05399.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script>
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
    </head>
    <body>
        <%
            Modelos.Usuarios.clsUsuarios obclsUsuarios = new Modelos.Usuarios.clsUsuarios();

            if (request.getAttribute("obclsUsuarios") != null) {
                obclsUsuarios = (Modelos.Usuarios.clsUsuarios) request.getAttribute("obclsUsuarios");
            }

            List<Modelos.Usuarios.clsUsuarios> lstclsUsuarios = new ArrayList<Modelos.Usuarios.clsUsuarios>();

            if (request.getAttribute("lstclsUsuarios") != null) {

                lstclsUsuarios = (List<Modelos.Usuarios.clsUsuarios>) request.getAttribute("lstclsUsuarios");
            }

            if (request.getAttribute("stMensaje") != null && request.getAttribute("stTipo") != null) {


        %>
        <input type="txt" hidden="" id="txtMensaje" value="<%=request.getAttribute("stMensaje")%>"/>
        <input type="txt" hidden="" id="txtTipo" value="<%=request.getAttribute("stTipo")%>"/>
        <script>
            var mensaje = document.getElementById("txtMensaje").value;
            var tipo = document.getElementById("txtTipo").value;
            swal("Mensaje", mensaje, tipo);
        </script>
        <%
            }
        %>
        <header>
            <%--Barra de Navegación de Jefe--%>
            <%
                if (Descripcion_perfil.equals("JEFE")) {
            %>
            <jsp:include page="../WEB-INF/jsp/menujefe.jsp"></jsp:include>
            <%
                }
            %>

            <%--Barra de Navegación de Administrador--%>
            <%
                if (Descripcion_perfil.equals("ADMINISTRADOR")) {
            %>
            <jsp:include page="../WEB-INF/jsp/menuadmin.jsp"></jsp:include>
            <%
                }
            %> 
        </header>
        <div class="container mt-4">
            <h1 class="text-center">Agregar Nuevo Usuario</h1>
            <br>
            <div class="card border-info">
                <div class="card-header bg-info text-white">
                    <a href="controlusuarios?btnUsuConsultar=true" class="btn btn-secondary"data-toggle="tooltip" title="Haz clic para regresar al menú usuarios"><i class="fas fa-arrow-left"></i></a>
                </div>
                <div class="card-body">
                    <form action="controlusuarios" method="POST">
                        <!--FILA-->
                        <div class="form-group">
                            <div class="row">
                                <div class="col-6">
                                    <label for="lblUsuario"><b>Usuario</b></label>
                                    <input type="text" class="form-control" name="txtUsuario"
                                           value="<%=obclsUsuarios.getId_Usuarios() != null ? obclsUsuarios.getId_Usuarios() : ""%>"/>
                                </div> 
                            </div>
                        </div>
                        <!--FILA-->
                        <div class="form-group">
                            <div class="row">
                                <div class="col-6">
                                    <label for="lblContraseña"><b>Contraseña</b></label>
                                    <input type="text" class="form-control" name="txtContraseña"
                                           value="<%=obclsUsuarios.getContraseña() != null ? obclsUsuarios.getContraseña() : ""%>"/>
                                </div>
                                <div class="col-6">
                                    <label for="lblcContraseña"><b>Confirmar Contraseña</b></label>
                                    <input type="text" class="form-control" name="txtConfirmarContraseña"
                                           value="<%=obclsUsuarios.getContraseña() != null ? obclsUsuarios.getContraseña() : ""%>"/>                                           
                                </div>
                            </div>
                        </div>
                        <!--FILA-->
                        <div class="form-group">
                            <div class="form-row">
                                <div class="col-6">
                                    <label for="lblEmpleado"><b>Empleado</b></label>
                                    <select class="form-control" name="ddlEmpleado">
                                        <%
                                            List<Modelos.Usuarios.clsEmpleados> lstclsEmpleados = new ArrayList<Modelos.Usuarios.clsEmpleados>();
                                            if (request.getAttribute("lstclsEmpleados") != null) {
                                                lstclsEmpleados = (List<Modelos.Usuarios.clsEmpleados>) request.getAttribute("lstclsEmpleados");
                                            }
                                            for (Modelos.Usuarios.clsEmpleados elem : lstclsEmpleados) {
                                        %>
                                        <option value="<%=elem.getId_empleado()%>"
                                                <%=obclsUsuarios.getObclsEmpleado() != null ? obclsUsuarios.getObclsEmpleado().getId_empleado() == elem.getId_empleado() ? "selected" : "" : ""%>>
                                            <%=elem.getStPrimerNombre()%>
                                            <%=elem.getStSegundoNombre()%>
                                            <%=elem.getStPrimerApellido()%>
                                            <%=elem.getStSegundoApellido()%>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>                                    
                                <div class="col-6">
                                    <label for="lblPerfil"><b>Perfil</b></label>
                                    <select class="form-control" name="ddlPerfil">
                                        <%
                                            List<Modelos.Usuarios.clsPerfil> lstclsPerfil = new ArrayList<Modelos.Usuarios.clsPerfil>();
                                            if (request.getAttribute("lstclsPerfil") != null) {
                                                lstclsPerfil = (List<Modelos.Usuarios.clsPerfil>) request.getAttribute("lstclsPerfil");
                                            }
                                            for (Modelos.Usuarios.clsPerfil elem : lstclsPerfil) {
                                        %>
                                        <option value="<%=elem.getId_perfil()%>"
                                                <%=obclsUsuarios.getObclsPerfil() != null ? obclsUsuarios.getObclsPerfil().getId_perfil() == elem.getId_perfil() ? "selected" : "" : ""%>>
                                            <%=elem.getStDescripcion_Perfil()%>
                                        </option>
                                        <%
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>                       
                        <!--FILA-->   
                        <div class="form-group">
                            <div class="form-row">
                                <div class="col-12">
                                    <input type="submit" value="Guardar" class="btn btn-info" data-toggle="tooltip" title="Haz clic para guardar" name="btnUsuGuardar"/>
                                </div>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </body>
    <script>
        $(document).ready(main);

        var contador = 1;

        function main() {
            $('.menu_bar').click(function () {
                if (contador == 1) {
                    $('nav').animate({
                        left: '0'
                    });
                    contador = 0;
                } else {
                    contador = 1;
                    $('nav').animate({
                        left: '-100%'
                    });
                }
            });

            // Mostramos y ocultamos submenus
            $('.submenu').click(function () {
                $(this).children('.children').slideToggle();
            });
        }
    </script>
</html>
