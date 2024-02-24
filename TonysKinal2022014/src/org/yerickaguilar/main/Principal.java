/*
    Nombre: Yerick      Oseas Aguilar Gramajo
    Número de carnet:   2022014
    Código Técnico:     IN5AV
    Fecha de creación:  11/04/2023
 */
package org.yerickaguilar.main;

import java.io.InputStream;
import java.util.logging.Level;
import java.util.logging.Logger;
import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.fxml.JavaFXBuilderFactory;
import javafx.scene.Scene;
import javafx.scene.image.Image;
import javafx.scene.layout.AnchorPane;
import javafx.stage.Stage;
import org.yerickaguilar.controller.EmpresaController;
import org.yerickaguilar.controller.LoginController;
import org.yerickaguilar.controller.MenuPrincipalController;
import org.yerickaguilar.controller.PresupuestoController;
import org.yerickaguilar.controller.ProductoController;
import org.yerickaguilar.controller.ProgramadorController;
import org.yerickaguilar.controller.ServicioController;
import org.yerickaguilar.controller.TipoPlatoController;
import org.yerickaguilar.controller.UsuarioController;

/**
 *
 * @author informatica
 */
public class Principal extends Application {
    private final String PAQUETE_VISTA = "/org/yerickaguilar/view/";
    private Stage escenarioPrincipal;
    private Scene escena;
    
    @Override
    public void start(Stage escenarioPrincipal) throws Exception {
        this.escenarioPrincipal = escenarioPrincipal;
        escenarioPrincipal.setTitle("Tony´s Kinal 2023");
        escenarioPrincipal.getIcons().add(new Image("/org/yerickaguilar/image/Icono.png"));
        escenarioPrincipal.setResizable(false);
        ventanaLogin();
        escenarioPrincipal.show();
        
    }
    
    public void menuPrincipal(){
        try {
            MenuPrincipalController menu = (MenuPrincipalController)cambiarEscena("MenuPrincipalView.fxml", 770, 580);
            menu.setEscenarioPrincipal(this);
        } catch (Exception e){
            e.printStackTrace();
        }
        
    }
    
    public void ventanaProgramador(){
        try {
            ProgramadorController programador = (ProgramadorController)cambiarEscena("ProgramadorView.fxml", 480, 220);
            programador.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void ventanaEmpresa(){
        try {
            EmpresaController empresa = (EmpresaController)cambiarEscena("EmpresaView.fxml", 900, 630);
            empresa.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void ventanaProducto(){
        try {
            ProductoController producto = (ProductoController)cambiarEscena("ProductoView.fxml", 900, 630);
            producto.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void ventanaServicio(){
        try {
            ServicioController servicio = (ServicioController) cambiarEscena("ServicioView.fxml", 1038, 630);
            servicio.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void ventanaPresupuesto(){
        try {
            PresupuestoController presupuesto = (PresupuestoController)cambiarEscena("PresupuestoView.fxml", 900, 630);
            presupuesto.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
        
    public void ventanaLogin(){
        try {
            LoginController loginController = (LoginController)cambiarEscena("LoginView.fxml", 700, 500);
            loginController.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    public void ventanaUsuario(){
        try {
            UsuarioController usuarioController = (UsuarioController)cambiarEscena("UsuarioView.fxml", 900, 630);
            usuarioController.setEscenarioPrincipal(this);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    
    
    public static void main(String[] args) {
        launch(args);
    }
    
    public Initializable cambiarEscena(String fxml, int ancho, int alto) throws Exception{
        Initializable resultado = null;
        FXMLLoader cargadorFXML = new FXMLLoader();
        InputStream archivo = Principal.class.getResourceAsStream(PAQUETE_VISTA+fxml);
        cargadorFXML.setBuilderFactory(new JavaFXBuilderFactory());
        cargadorFXML.setLocation(Principal.class.getResource(PAQUETE_VISTA+fxml));
        escena = new Scene((AnchorPane)cargadorFXML.load(archivo),ancho,alto);
        escenarioPrincipal.setScene(escena);
        escenarioPrincipal.sizeToScene();
        resultado = (Initializable)cargadorFXML.getController();
        return resultado;
    }
}