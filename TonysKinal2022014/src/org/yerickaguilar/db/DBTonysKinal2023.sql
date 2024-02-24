/*
	Yerick Oseas
    AguilarGramajo
    2022014
    IN5AV
*/
Drop database if exists DBTonysKinal2023;
Create database DBTonysKinal2023;
Use DBTonysKinal2023;

Create table Empresas(
	codigoEmpresa int not null auto_increment,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(8) not null,
    primary key PK_codigoEmpresa(codigoEmpresa)
);

Create table TipoEmpleado(
	codigoTipoEmpleado int not null auto_increment,
    descripcion varchar(150) not null,
    primary key PK_codigoTipoEmpleado(codigoTipoEmpleado)
);

Create table TipoPlato(
	codigoTipoPlato int not null auto_increment,
    descripcionTipo varchar(100) not null,
    primary key PK_codigoTipoPlato(codigoTipoPlato)
);

Create table Productos(
	codigoProducto int not null auto_increment,
    nombreProducto varchar(150) not null,
    cantidad int not null,
    primary key PK_codigoProducto(codigoProducto)
);

Create table Empleados(
	codigoEmpleado int not null auto_increment,
    numeroEmpleado int not null,
    apellidosEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(8) not null,
    gradoCocinero varchar(50),
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado(codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key
		(codigoTipoEmpleado) references TipoEmpleado(codigoTipoEmpleado)
);

Create table Servicios(
	codigoServicio int not null auto_increment,
    fechaServicio date not null,
    tipoServicio varchar(150) not null,
    horaServicio time not null,
    lugarServicio varchar(150) not null,
    telefonoContacto varchar(8),
    codigoEmpresa int not null,
    primary key PK_codigoServicio(codigoServicio),
    constraint FK_Servicios_Empresa foreign key
		(codigoEmpresa) references Empresas(codigoEmpresa)
);

Create table Presupuesto(
	codigoPresupuesto int not null auto_increment,
    fechaSolicitud date not null,
    cantidadPresupuesto decimal(10,2) not null,
    codigoEmpresa int not null,
    primary key PK_codigoPresupuesto(codigoPresupuesto),
    constraint FK_Presupuesto_Empresa foreign key
		(codigoEmpresa) references Empresas(codigoEmpresa)
);

Create table Platos(
	codigoPlato int not null auto_increment,
    cantidad int not null,
    nombrePlato varchar(50) not null,
    descripcionPlato varchar(150) not null,
    precioPlato decimal(10,2) not null,
    codigoTipoPlato int not null,
    primary key PK_codigoPlato(codigoPlato),
    constraint FK_Platos_TipoPlato foreign key
		(codigoTipoPlato) references TipoPlato(codigoTipoPlato)
);

Create table Productos_has_Platos(
	Productos_codigoProducto int not null,
    codigoPlato int not null,
    codigoProducto int not null,
    primary key PK_Productos_codigoProducto(Productos_codigoProducto),
    constraint FK_Productos_has_platos_Productos foreign key
		(codigoProducto) references Productos(codigoProducto)
);

Create table Servicios_has_Platos(
	Servicios_codigoServicio int not null,
    codigoPlato int not null,
    codigoServicio int not null,
    primary key PK_Servicios_codigoServicio(Servicios_codigoServicio),
    constraint FK_Servicios_has_platos_Servicios foreign key
		(codigoServicio) references Servicios(codigoServicio),
	constraint FK_Servicios_has_platos_Platos foreign key
		(codigoPlato) references Platos(codigoPlato)
);

Create table Servicios_has_Empleados(
	Servicios_codigoServicio int not null,
    codigoServicio int not null,
    codigoEmpleado int not null,
    fechaEvento date not null,
    horaEvento time not null,
    lugarEvento varchar(150) not null,
    primary key PK_Servicios_codigoServicio(Servicios_codigoServicio),
    constraint FK_Servicios_has_Empleados_Servicios foreign key
		(codigoServicio) references Servicios(codigoServicio),
	constraint FK_Servicios_has_Empleados_Empleados foreign key
		(codigoEmpleado) references Empleados(codigoEmpleado)
);

Create table Usuario(
	codigoUsuario int not null auto_increment,
    nombreUsuario varchar(100) not null,
    apellidoUsuario varchar(100) not null,
    usuarioLogin varchar(50) not null,
    contrasena varchar(50) not null,
    primary key PK_codigoUsuario(codigoUsuario)
);

-- -------------------- Procedimientos almacenados --------------------
-- -------------------- Emmpresas -------------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarEmpresa(in nombreEmpresa varchar(150), in direccion varchar(150), in telefono varchar(8))
    Begin
		Insert into Empresas(nombreEmpresa, direccion, telefono)
			values (nombreEmpresa, direccion, telefono);
    End$$
Delimiter ;
call sp_AgregarEmpresa('BurgerKing','7mva avenida zona 6','15748534');
-- Editar
Delimiter $$
	Create procedure sp_EditarEmpresa(in codEmpresa int, in nombreEmpresaNuevo varchar(150), in direccionNuevo varchar(150), in telefonoNuevo varchar(8))
    Begin
		update Empresas E
			set E.nombreEmpresa = nombreEmpresaNuevo,
				E.direccion = direccionNuevo,
                E.telefono = telefonoNuevo
				where codigoEmpresa = codEmpresa;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarEmpresa(in codEmpresa int)
    Begin
		Delete from Empresas where codigoEmpresa = codEmpresa;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarEmpresas()
    Begin
		Select
			E.codigoEmpresa,
            E.nombreEmpresa,
            E.direccion,
            E.telefono
            From Empresas E;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	create procedure sp_BuscarEmpresa(in codEmpresa int)
    Begin
		Select
			E.codigoEmpresa,
            E.nombreEmpresa,
            E.direccion,
            E.telefono
            From Empresas E where codigoEmpresa = codEmpresa;
    End$$
Delimiter ;

-- -------------------- TipoEmpleado --------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarTipoEmpleado(in descripcion varchar(150))
    Begin
		Insert into TipoEmpleado(descripcion)
			values (descripcion);
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarTipoEmpleado(in codTipoEmpleado int, in descripcionNuevo varchar(150))
    Begin
		Update TipoEmpleado T
			set T.descripcion = descripcionNuevo
				where codigoTipoEmpleado = codTipoEmpleado;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarTipoEmpleado(in codTipoEmpleado int)
    Begin
		Delete from TipoEmpleado where codigoTipoEmpleado = codTipoEmpleado;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarTiposEmpleados()
    Begin
		Select
			T. codigoTipoEmpleado,
            T.descripcion
            From TipoEmpleado T;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarTipoEmpleado(in codTipoEmpleado int)
    Begin
		Select
			T. codigoTipoEmpleado,
            T.descripcion
            From TipoEmpleado T where codigoTipoEmpleado = codTipoEmpleado;
    End$$
Delimiter ;

-- -------------------- TipoPlato -----------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarTipoPlato(in descripcionTipo varchar(100))
    Begin
		Insert into TipoPlato(descripcionTipo)
			values(descripcionTipo);
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarTipoPlato(in codTipoPlato int, in descripcionTipoNuevo varchar(100))
    Begin
		Update TipoPlato T
			set T.descripcionTipo = descripcionTipoNuevo
				where codigoTipoPlato = codTipoPlato;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarTipoPlato(in codTipoPlato int)
    Begin
		Delete from TipoPlato where codigoTipoPlato = codTipoPlato;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarTiposPlatos()
    Begin
		Select
			T.codigoTipoPlato,
            T.descripcionTipo
            From TipoPlato T;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarTipoPlato(in codTipoPlato int)
    Begin
		Select
			T.codigoTipoPlato,
            T.descripcionTipo
            From TipoPlato T where codigoTipoPlato = codTipoPlato;
    End$$
Delimiter ;

-- -------------------- Productos -----------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarProducto(in nombreProducto varchar(150), in cantidad int)
    Begin
		Insert into Productos(nombreProducto,cantidad)
			values(nombreProducto,cantidad);
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarProducto(in codProducto int, in nombreProductoNuevo varchar(150), in cantidadNueva int)
    Begin
		Update Productos P
		set P.nombreProducto = nombreProductoNuevo,
			P.cantidad = cantidadNueva
            where codigoProducto = codProducto;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarProducto(in codProducto int)
    Begin
		Delete from Productos where codigoProducto = codProducto;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarProductos()
    Begin
		Select
			P.codigoProducto,
            P.nombreProducto,
            P.cantidad
            From Productos P;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarProducto(in codProducto int)
    Begin
		Select
			P.codigoProducto,
            P.nombreProducto,
            P.cantidad
            From Productos P where codigoProducto = codProducto;
    End$$
Delimiter ;

-- -------------------- Empleados -----------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarEmpleado(in numeroEmpleado int, in apellidosEmpleado varchar(150), in nombresEmpleado varchar(150),
		in direccionEmpleado varchar(150), telefonoContacto varchar(8), in gradoCocinero varchar(50), codigoTipoEmpleado int)
		Begin
			Insert into Empelados(
				numeroEmpleado,
                apellidosEmpleado,
                nombresEmpleado,
                direccionEmpleado,
                telefonoContacto,
                gradoCocinero,
                codigoTipoEmpleado)
					values(
						numeroEmpleado,
						apellidosEmpleado,
						nombresEmpleado,
						direccionEmpleado,
						telefonoContacto,
						gradoCocinero,
                        codigoTipoEmpleado);
        End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarEmpleado(in codEmpleado int, in numeroEmpleadoNuevo int, in apellidosEmpleadoNuevo varchar(150), 
		in nombresEmpleadoNuevo varchar(150),in direccionEmpleadoNuevo varchar(150), telefonoContactoNuevo varchar(8), 
        in gradoCocineroNuevo varchar(50), codigoTipoEmpleadoNuevo int)
		Begin
			Update Empleados E
			set E.numeroEmpleado = numeroEmpleadoNuevo,
				E.apellidosEmpleado = apellidosEmpleadoNuevo,
                E.nombresEmpleado = nombresEmpleadoNuevo,
                E.direccionEmpleado = direccionEmpleadoNuevo,
                E.telefonoContancto = telefonoContactoNuevo,
                E.gradoCocinero = gradoCocineroNuevo,
                E.codigoTipoEmpleado = codigoTipoEmpleadoNuevo
                where codigoEmpleado = codEmpleado;
		End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarEmpleado(in codEmpleado int)
    Begin
		Delete from Empleados where codigoEmpleado = codEmpleado;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarEmpleados()
    Begin
		Select
			E.codigoEmpleado,
            E.numeroEmpleado, 
            E.apellidosEmpleado, 
            E.nombresEmpleado, 
            E.direccionEmpleado, 
            E.telefonoContacto, 
            E.gradoCocinero, 
            E.codigoTipoEmpleado
            from Empleados E;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarEmpleado(in codEmpleado int)
    Begin
		Select
			E.codigoEmpleado,
            E.numeroEmpleado, 
            E.apellidosEmpleado, 
            E.nombresEmpleado, 
            E.direccionEmpleado, 
            E.telefonoContacto, 
            E.gradoCocinero, 
            E.codigoTipoEmpleado
            from Empleados E where codigoEmpelado = codEmpleado;
    End$$
Delimiter ;

-- -------------------- Servicios -----------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarServicio(in fechaServicio date, in tipoServicio varchar(150), in horaServicio time, in lugarServicio varchar(150),
		in telefonoContacto varchar(8), in codigoEmpresa int)
        Begin
			Insert into Servicios(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa)
				values(fechaServicio, tipoServicio, horaServicio, lugarServicio, telefonoContacto, codigoEmpresa);
        End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarServicio(in codServicio int, in fechaServicioNuevo date, in tipoServicioNuevo varchar(150), in horaServicioNuevo time, 
		in lugarServicioNuevo varchar(150), in telefonoContactoNuevo varchar(8))
        Begin
			Update Servicios S
			set S.fechaServicio = fechaServicioNuevo,
				S.tipoServicio = tipoServicioNuevo,
                S.horaServicio = horaServicioNuevo, 
                S.lugarServicio = lugarServicioNuevo, 
                S.telefonoContacto = telefonoContactoNuevo
                where codigoServicio = codServicio;
        End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarServicio(in codServicio int)
    Begin
		Delete From Servicios where codigoServicio = codServicio;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarServicios()
    Begin
		Select
			S.codigoServicio, 
            S.fechaServicio, 
            S.tipoServicio, 
            S.horaServicio, 
            S.lugarServicio, 
            S.telefonoContacto, 
            S.codigoEmpresa
            from Servicios S;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarServicio(in codServicio int)
    Begin
		Select
			S.codigoServicio, 
            S.fechaServicio, 
            S.tipoServicio, 
            S.horaServicio, 
            S.lugarServicio, 
            S.telefonoContacto, 
            S.codigoEmpresa
            from Servicios S where codigoServicio = codServicio;
    End$$
Delimiter ;

-- -------------------- Presupuesto ---------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarPresupuesto(in fechaSolicitud date, in cantidadPresupuesto decimal(10,2), in codigoEmpresa int)
    Begin
		Insert into Presupuesto(fechaSolicitud, cantidadPresupuesto, codigoEmpresa)
			values(fechaSolicitud, cantidadPresupuesto, codigoEmpresa);
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarPresupuesto(in codPresupuesto int, in fechaSolicitudNuevo date, in cantidadPresupuestoNuevo decimal(10,2))
        Begin
			Update Presupuesto P
            set P.fechaSolicitud = fechaSolicitudNuevo, 
				P.cantidadPresupuesto = cantidadPresupuestoNuevo
                where codigoPresupuesto = codPresupuesto;
        End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarPresupuesto(in codPresupuesto int)
    Begin
		Delete from Presupuesto where codigoPresupuesto = codPresupuesto;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarPresupuestos()
    Begin
		Select
			P.codigoPresupuesto, 
            P.fechaSolicitud, 
            P.cantidadPresupuesto, 
            P.codigoEmpresa
            from Presupuesto P;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarPresupuestos(in codPresupuesto int)
    Begin
		Select
			P.codigoPresupuesto, 
            P.fechaSolicitud, 
            P.cantidadPresupuesto, 
            P.codigoEmpresa
            from Presupuestos P where codigoPresupuesto = codPresupuesto;
    End$$
Delimiter ;

-- -------------------- Platos --------------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarPlato(in cantidad int, in nombrePlato varchar(50), in descripcionPlato varchar(150), in precioPlato decimal(10,2), 
		in codigoTipoPlato int)
        Begin
			Insert into Platos(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato)
				values(cantidad, nombrePlato, descripcionPlato, precioPlato, codigoTipoPlato);
        End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarPlato(in codPlato int, in cantidadNuevo int, in nombrePlatoNuevo varchar(50), in descripcionPlatoNuevo varchar(150), 
		in precioPlatoNuevo decimal(10,2), in codigoTipoPlatoNuevo int)
        Begin
			Update Platos P
            set P.cantidad = cantidadNuevo, 
				P.nombrePlato = nombrePlatoNuevo, 
                P.descripcionPlato = descripcionPlatoNuevo, 
                P.precioPlato = precioPlatoNuevo, 
                P.codigoTipoPlato = codigoTipoPlatoNuevo
                where codigoPlato = codPlato;
        End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarPlato(in codPlato int)
    Begin
		Delete from Platos where codigoPlato = codPlato;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarPlatos()
    Begin
		Select
			P.codigoPlato, 
            P.cantidad, 
            P.nombrePlato, 
            P.descripcionPlato, 
            P.precioPlato, 
            P.codigoTipoPlato
            from Platos P;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarPlatos(in codPlato int)
    Begin
		Select
			P.codigoPlato, 
            P.cantidad, 
            P.nombrePlato, 
            P.descripcionPlato, 
            P.precioPlato, 
            P.codigoTipoPlato
            from Platos P where codigoPlato = codPlato;
    End$$
Delimiter ;

-- -------------------- Productos has Platos ------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarProductosHasPlatos(in codigoPlato int, in codigoProducto int)
    Begin
		Insert into Productos_has_platos(codigoPlato, codigoProducto)
			values(codigoPlato, codigoProducto);
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarProductosHasPlatos(in codProductos_codigoProducto int, in codigoPlatoNuevo int, in codigoProductoNuevo int)
    Begin
		Update Productos_has_platos P
        set P.codigoPlato = codigoPlatoNuevo, 
			P.codigoProducto = codigoProductoNuevo
            where Productos_codigoProducto = codProductos_codigoProducto;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarProductosHasPlatos(in codProductos_codigoProducto int)
    Begin
		Delete from Productos_has_platos where Productos_codigoProducto = codProductos_codigoProducto;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarProductosHasPlatos()
    Begin
		Select
			P.codigoPlato, 
            P.codigoProducto
            from Productos_has_platos P;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarProductosHasPlatos(in codProductos_codigoProducto int)
    Begin
		Select
			P.codigoPlato, 
            P.codigoProducto
            from Productos_has_platos P where Productos_codigoProducto = codProductos_codigoProducto;
    End$$
Delimiter ;

-- -------------------- Servicios has Platos ------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarServicios_has_platos(in codigoPlato int, in codigoServicio int)
    Begin
		Insert into servicios_has_platos(codigoPlato, codigoServicio)
			values(codigoPlato, codigoServicio);
    End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarServicios_has_platos(in codServicios_codigoServicio int, in codigoPlatoNuevo int, in codigoServicioNuevo int)
    Begin
		Update Servicios_has_platos S
		set S.codigoPlato = codigoPlatoNuevo, 
			S.codigoServicio = codigoServicioNuevo
            where Servicios_codigoServicio = codServicios_codigoServicio;
    End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarServicios_has_platos(in codServicios_codigoServicio int)
    Begin
		Delete from Servicios_has_platos where Servicios_codigoServicio = codServicios_codigoServicio;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarServicios_has_platos()
    Begin
		Select
			S.Servicios_codigoServicio, 
            S.codigoPlato, 
            S.codigoServicio
            from Servicios_has_platos;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarServicios_has_platos(in codServicios_codigoServicio int)
    Begin
		Select
			S.Servicios_codigoServicio, 
            S.codigoPlato, 
            S.codigoServicio
            from Servicios_has_platos where Servicios_codigoServicio = codServicios_codigoServicio;
    End$$
Delimiter ;

-- -------------------- Servicios has Empleados ---------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarServicios_has_empleados(in codigoServicio int, in codigoEmpleado int, in fechaEvento date, 
		in horaEvento time, in lugarEvento varchar(150))
        Begin
			Insert into Servicios_has_empleados(codigoServicio, codigoEmpleado, fechaEvento, horaEvento, lugarEvento)
				values(codigoServicio, codigoEmpleado, fechaEvento, horaEvento, lugarEvento);
        End$$
Delimiter ;

-- Editar
Delimiter $$
	Create procedure sp_EditarServicios_has_empleados(in codServicios_codigoServicio int,in codigoServicioNuevo int, in codigoEmpleadoNuevo int, 
		in fechaEventoNuevo date, in horaEventoNuevo time, in lugarEventoNuevo varchar(150))
        Begin
			Update Servicios_has_empleados S
            set S.codigoServicio = codigoServicioNuevo, 
				S.codigoEmpleado = codigoEmpleadoNuevo, 
                S.fechaEvento = fechaEventoNuevo, 
                S.horaEvento = horaEventoNuevo, 
                S.lugarEvento = lugarEventoNuevo
                where Servicios_codigoServicio = codServicios_codigoServicio;
        End$$
Delimiter ;

-- Eliminar
Delimiter $$
	Create procedure sp_EliminarServicios_has_empleados(in codServicios_codigoServicio int)
    Begin
		Delete from Servicios_has_empleados where Servicios_codigoServicio = codServicios_codigoServicio;
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarServicios_has_empleados()
    Begin
		Select
			S.Servicios_codigoServicio, 
            S.codigoServicio, 
            S.codigoEmpleado, 
            S.fechaEvento, 
            S.horaEvento, 
            S.lugarEvento
            from Servicios_has_empleados S;
    End$$
Delimiter ;

-- Buscar
Delimiter $$
	Create procedure sp_BuscarServicios_has_empleados(in codServicios_codigoServicio int)
    Begin
		Select
			S.Servicios_codigoServicio, 
            S.codigoServicio, 
            S.codigoEmpleado, 
            S.fechaEvento, 
            S.horaEvento, 
            S.lugarEvento
            from Servicios_has_empleados S where Servicios_codigoServicio = codServicios_codigoServicio;
    End$$
Delimiter ;

-- ------------------------------ Usuario -----------------------------------
-- Agregar
Delimiter $$
	Create procedure sp_AgregarUsuario(in nombreUsuario varchar(100), in apellidoUsuario varchar(100), in usuarioLogin varchar(50), in contrasena varchar(50))
    Begin
		Insert into Usuario(nombreUsuario, apellidoUsuario, usuarioLogin, contrasena)
			values(nombreUsuario, apellidoUsuario, usuarioLogin, contrasena);
    End$$
Delimiter ;

-- Listar
Delimiter $$
	Create procedure sp_ListarUsuarios()
    Begin
		Select
			U.codigoUsuario, 
            U.nombreUsuario, 
            U.apellidoUsuario, 
            U.usuarioLogin, 
            U.contrasena
            from Usuario U;
    End$$
Delimiter ;

call sp_AgregarServicio('2023-06-09','Cena','06:04:00','Mixco','14789632',1);
call sp_AgregarUsuario('Pedro','Armas','parmas','parmas');
call sp_ListarServicios();
call sp_ListarUsuarios();