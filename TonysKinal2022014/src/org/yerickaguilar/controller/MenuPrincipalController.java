package org.yerickaguilar.controller;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.animation.TranslateTransition;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.image.ImageView;
import javafx.scene.layout.AnchorPane;
import javafx.util.Duration;
import org.yerickaguilar.main.Principal;

public class MenuPrincipalController implements Initializable{ 
    private Principal escenarioPrincipal;
    @FXML private AnchorPane paneLateral;
    @FXML private Button btnExpandir;
    @FXML private Button btnContraer;
    @FXML private ImageView imgExpandir;
    @FXML private ImageView imgContraer;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        paneLateral.setTranslateX(-235);
        btnExpandir.setVisible(true);
        imgExpandir.setVisible(true);
        btnContraer.setVisible(false);
        imgContraer.setVisible(false);
    }
    
    public void expandirMenu(){
        TranslateTransition deslizar = new TranslateTransition();
        deslizar.setDuration(Duration.seconds(0.4));
        deslizar.setNode(paneLateral);
        
        deslizar.setToX(0);
        deslizar.play();
        
        paneLateral.setTranslateX(-200);
        deslizar.setOnFinished((ActionEvent e) -> {
            btnExpandir.setVisible(false);
            imgExpandir.setVisible(false);
            btnContraer.setVisible(true);
            imgContraer.setVisible(true);
        });
    }
    
    public void contraerMenu(){
        TranslateTransition deslizar = new TranslateTransition();
        deslizar.setDuration(Duration.seconds(0.4));
        deslizar.setNode(paneLateral);
        
        deslizar.setToX(-235);
        deslizar.play();
        
        paneLateral.setTranslateX(0);
        deslizar.setOnFinished((ActionEvent e) -> {
            btnExpandir.setVisible(true);
            imgExpandir.setVisible(true);
            btnContraer.setVisible(false);
            imgContraer.setVisible(false);
        });
    }

    public Principal getEscenarioPrincipal() {
        return escenarioPrincipal;
    }

    public void setEscenarioPrincipal(Principal escenarioPrincipal) {
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
    
    public void ventanaProgramador(){
        escenarioPrincipal.ventanaProgramador();
    }
    
    public void ventanaEmpresa(){
        escenarioPrincipal.ventanaEmpresa();
    }
    
    public void ventanaProducto(){
        escenarioPrincipal.ventanaProducto();
    }
    
    public void ventanaPresupuesto(){
        escenarioPrincipal.ventanaPresupuesto();
    }
    
    public void ventanaLogin(){
        escenarioPrincipal.ventanaLogin();
    }
    
    public void ventanaUsuario(){
        escenarioPrincipal.ventanaUsuario();
    }
    
    public void ventanaServicio(){
        escenarioPrincipal.ventanaServicio();
    }
}
