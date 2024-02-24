package org.yerickaguilar.controller;

import com.jfoenix.controls.JFXDatePicker;
import com.jfoenix.controls.JFXTimePicker;
import java.net.URL;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.ComboBox;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextField;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.ImageView;
import javax.swing.JOptionPane;
import org.yerickaguilar.bean.Empresa;
import org.yerickaguilar.bean.Servicio;
import org.yerickaguilar.db.Conexion;
import org.yerickaguilar.main.Principal;

public class ServicioController implements Initializable{
    private Principal escenarioPrincipal;
    private enum operaciones{GUARDAR, ELIMINAR, ACTUALIZAR, NINGUNO}
    private operaciones tipoDeOperacion = operaciones.NINGUNO;
    private ObservableList<Servicio> listaServicio;
    private ObservableList<Empresa> listaEmpresa;

    @FXML private TextField txtCodigoServicio;
    @FXML private TextField txtTipoServicio;
    @FXML private TextField txtLugarServicio;
    @FXML private TextField txtTelefonoContacto;
    @FXML private ComboBox cmbCodigoEmpresa;
    @FXML private TableView tblServicios;
    @FXML private TableColumn colCodigoServicio;
    @FXML private TableColumn colFechaServicio;
    @FXML private TableColumn colTipoServicio;
    @FXML private TableColumn colHoraServicio;
    @FXML private TableColumn colLugarServicio;
    @FXML private TableColumn colTelefono;
    @FXML private TableColumn colCodigoEmpresa;
    @FXML private Button btnAgregar;
    @FXML private Button btnEliminar;
    @FXML private Button btnEditar;
    @FXML private Button btnReporte;
    @FXML private ImageView imgAgregar;
    @FXML private ImageView imgEliminar;
    @FXML private ImageView imgEditar;
    @FXML private ImageView imgReporte;
    @FXML private JFXDatePicker datePicker;
    @FXML private JFXTimePicker timePicker;
    
    @Override
    public void initialize(URL location, ResourceBundle resources) {
        cargarDatos();
        cmbCodigoEmpresa.setItems(getEmpresa());
        desactivarControles();
    }
    
    public void cargarDatos(){
        tblServicios.setItems(getServicio());
        colCodigoServicio.setCellValueFactory(new PropertyValueFactory<Servicio,Integer>("codigoServicio"));
        colFechaServicio.setCellValueFactory(new PropertyValueFactory<Servicio,JFXDatePicker>("fechaServicio"));
        colTipoServicio.setCellValueFactory(new PropertyValueFactory<Servicio,String>("tipoServicio"));
        colHoraServicio.setCellValueFactory(new PropertyValueFactory<Servicio,JFXTimePicker>("horaServicio"));
        colLugarServicio.setCellValueFactory(new PropertyValueFactory<Servicio,String>("lugarServicio"));
        colTelefono.setCellValueFactory(new PropertyValueFactory<Servicio,String>("telefonoContacto"));
        colCodigoEmpresa.setCellValueFactory(new PropertyValueFactory<Servicio,Integer>("codigoEmpresa"));
        
        
    }
    
    public void seleccionarElemento(){
        if(tblServicios.getSelectionModel().getSelectedIndex()>=0&& tblServicios.getSelectionModel().getSelectedIndex()<tblServicios.getItems().size()){
            txtCodigoServicio.setText(String.valueOf(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getCodigoServicio()));
            txtTipoServicio.setText(String.valueOf(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getTipoServicio()));
            txtLugarServicio.setText(String.valueOf(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getLugarServicio()));
            txtTelefonoContacto.setText(String.valueOf(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getTelefonoContacto()));
            cmbCodigoEmpresa.getSelectionModel().select(buscarEmpresa(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getCodigoEmpresa()));
            datePicker.setValue(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getFechaServicio());
            timePicker.setValue(((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getHoraServicio());
        }else{
            JOptionPane.showMessageDialog(null, "Seleccione un registro Existente");
       }
    }
    
    public Empresa buscarEmpresa(int codigoEmpresa){
        Empresa resultado = null;
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_BuscarEmpresa(?)");
            procedimiento.setInt(1, codigoEmpresa);
            ResultSet registro = procedimiento.executeQuery();
            while (registro.next()) {                
                resultado = new Empresa(registro.getInt("codigoEmpresa"),
                    registro.getString("nombreEmpresa"),
                    registro.getString("direccion"),
                    registro.getString("telefono"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return resultado;
    }
    
    public ObservableList<Servicio> getServicio(){
        ArrayList<Servicio> lista = new ArrayList<Servicio>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_ListarServicios()");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {                
                lista.add(new Servicio(resultado.getInt("codigoServicio"), 
                        resultado.getObject("fechaServicio",LocalDate.class), 
                        resultado.getString("tipoServicio"), 
                        resultado.getObject("horaServicio",LocalTime.class), 
                        resultado.getString("lugarServicio"), 
                        resultado.getString("telefonoContacto"), 
                        resultado.getInt("codigoEmpresa")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaServicio = FXCollections.observableArrayList(lista);
    }
    
    public ObservableList<Empresa> getEmpresa(){
        ArrayList<Empresa> lista = new ArrayList<Empresa>();
        try {
            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_ListarEmpresas");
            ResultSet resultado = procedimiento.executeQuery();
            while (resultado.next()) {                
                lista.add(new Empresa(resultado.getInt("codigoEmpresa"),
                        resultado.getString("nombreEmpresa"),
                        resultado.getString("direccion"),
                        resultado.getString("telefono")));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return listaEmpresa = FXCollections.observableArrayList(lista);
    }
    
    public void agregar(){
        switch(tipoDeOperacion){
            case NINGUNO:
                activarControles();
                limpiarControles();
                btnAgregar.setText("Guardar");
                btnEliminar.setText("Cancelar");
                btnEditar.setDisable(true);
                btnReporte.setDisable(true);
                tipoDeOperacion = operaciones.GUARDAR;
            break;
            case GUARDAR:
                
                if(verificarNumeros()==true){
                    guardar();
                    limpiarControles();
                    desactivarControles();
                    btnAgregar.setText("Agregar");
                    btnEliminar.setText("Eliminar");
                    btnEditar.setDisable(false);
                    btnReporte.setDisable(false);
                    tipoDeOperacion = operaciones.NINGUNO;
                    cargarDatos();
                }else{
                    limpiarControles();
                    desactivarControles();
                    btnAgregar.setText("Agregar");
                    btnEliminar.setText("Eliminar");
                    btnEditar.setDisable(false);
                    btnReporte.setDisable(false);
                    JOptionPane.showMessageDialog(null, "Debe Ingresar 8 dígitos en Teléfono");
                    tipoDeOperacion = operaciones.NINGUNO;
                }
            break;
        }
    }
    
    public void guardar(){
        // Verificación de datos vacíos
        if(txtTipoServicio.getText().length() == 0 || 
            txtLugarServicio.getText().length() == 0 ||
            txtTelefonoContacto.getText().length() == 0 ||
            cmbCodigoEmpresa.getSelectionModel().isEmpty() ||
            datePicker.getValue() == null ||
            timePicker.getValue() == null){
            JOptionPane.showMessageDialog(null, "Tiene datos vacíos");
        }else{
            Servicio registro = new Servicio();
            registro.setFechaServicio(datePicker.getValue());
            registro.setTipoServicio(txtTipoServicio.getText());
            registro.setHoraServicio(timePicker.getValue());
            registro.setLugarServicio(txtLugarServicio.getText());
            registro.setTelefonoContacto(txtTelefonoContacto.getText());
            registro.setCodigoEmpresa(((Empresa)cmbCodigoEmpresa.getSelectionModel().getSelectedItem()).getCodigoEmpresa());
            try {
                // Llamada al preocedimiento almacenado
                PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_AgregarServicio(?,?,?,?,?,?)");
                
                // Establecer los valores de los parámetros
                procedimiento.setObject(1, registro.getFechaServicio());
                /*
                    El método 'setObject' permite establecer un valor en un parámetro 
                    sin necesidad de especificar explícitamente el tipo de dato.
                */
                procedimiento.setString(2, registro.getTipoServicio());
                procedimiento.setObject(3, registro.getHoraServicio());
                procedimiento.setString(4, registro.getLugarServicio());
                procedimiento.setString(5, registro.getTelefonoContacto());
                procedimiento.setInt(6, registro.getCodigoEmpresa());
                procedimiento.execute();
                listaServicio.add(registro);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public void eliminar(){
        switch(tipoDeOperacion){
            case GUARDAR:
                limpiarControles();
                desactivarControles();
                btnAgregar.setText("Agregar");
                btnEliminar.setText("Eliminar");
                btnEditar.setDisable(false);
                btnReporte.setDisable(false);
                tipoDeOperacion = operaciones.NINGUNO;
            break;
            default:
                if(tblServicios.getSelectionModel().getSelectedItem()!=null){
                    int respuesta = JOptionPane.showConfirmDialog(null, "¿ Desea eliminar el registro ?","Eliminar Servicio",JOptionPane.YES_OPTION);
                    if(respuesta == JOptionPane.YES_OPTION){
                        try {
                            PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_EliminarServicio(?)");
                            procedimiento.setInt(1, ((Servicio)tblServicios.getSelectionModel().getSelectedItem()).getCodigoServicio());
                            procedimiento.execute();
                            listaServicio.remove(tblServicios.getSelectionModel().getSelectedIndex());
                            tblServicios.getSelectionModel().clearSelection();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }else{
                        limpiarControles();
                        desactivarControles();
                    }
                }else{
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un registro");
                }
            break;
        }
    }
    
    public void actualizar(){
        if(txtTipoServicio.getText().length() == 0 || 
            txtLugarServicio.getText().length() == 0 ||
            txtTelefonoContacto.getText().length() == 0 ||
            datePicker.getValue() == null ||
            timePicker.getValue() == null){
            JOptionPane.showMessageDialog(null, "Tiene datos vacíos");
        }else{
            try {
                PreparedStatement procedimiento = Conexion.getInstance().getConexion().prepareCall("call sp_EditarServicio(?,?,?,?,?,?)");
                Servicio registro = (Servicio)tblServicios.getSelectionModel().getSelectedItem();
                registro.setFechaServicio(datePicker.getValue());
                registro.setTipoServicio(txtTipoServicio.getText());
                registro.setHoraServicio(timePicker.getValue());
                registro.setLugarServicio(txtLugarServicio.getText());
                registro.setTelefonoContacto(txtTelefonoContacto.getText());
                procedimiento.setInt(1, registro.getCodigoServicio());
                procedimiento.setObject(2, registro.getFechaServicio());
                procedimiento.setString(3, registro.getTipoServicio());
                procedimiento.setObject(4, registro.getHoraServicio());
                procedimiento.setString(5, registro.getLugarServicio());
                procedimiento.setString(6, registro.getTelefonoContacto());
                procedimiento.execute();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }
    
    public void editar(){
        switch(tipoDeOperacion){
            case NINGUNO:
                if(tblServicios.getSelectionModel().getSelectedItem() != null){
                    btnAgregar.setDisable(true);
                    btnEliminar.setDisable(true);
                    btnEditar.setText("Actualizar");
                    btnReporte.setText("Cancelar");
                    activarControles();
                    btnReporte.setVisible(true);
                    cmbCodigoEmpresa.setDisable(true);
                    tipoDeOperacion = operaciones.ACTUALIZAR;
                }else{
                    JOptionPane.showMessageDialog(null, "Debe seleccionar un elemento");
                }
            break;
            case ACTUALIZAR:
                actualizar();
                limpiarControles();
                desactivarControles();
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText("Editar");
                btnReporte.setText("Reporte");
                btnReporte.setVisible(false);
                cargarDatos();
                tipoDeOperacion = operaciones.NINGUNO;
            break;
        }
    }
    
    public void reporte(){
        switch(tipoDeOperacion){
            case ACTUALIZAR:
                limpiarControles();
                desactivarControles();
                btnAgregar.setDisable(false);
                btnEliminar.setDisable(false);
                btnEditar.setText("Editar");
                btnReporte.setVisible(false);
                tipoDeOperacion = operaciones.NINGUNO;
            break;
            case NINGUNO:
            break;
        }
    }
    
    public void desactivarControles(){
        txtCodigoServicio.setDisable(true);
        txtTipoServicio.setDisable(true);
        txtLugarServicio.setDisable(true);
        txtTelefonoContacto.setDisable(true);
        cmbCodigoEmpresa.setDisable(true);
        datePicker.setDisable(true);
        timePicker.setDisable(true);
    }
    
    public void activarControles(){
        txtTipoServicio.setDisable(false);
        txtLugarServicio.setDisable(false);
        txtTelefonoContacto.setDisable(false);
        cmbCodigoEmpresa.setDisable(false);
        datePicker.setDisable(false);
        timePicker.setDisable(false);
    }
    
    public void limpiarControles(){
        txtCodigoServicio.clear();
        txtTipoServicio.clear();
        txtLugarServicio.clear();
        txtTelefonoContacto.clear();
        cmbCodigoEmpresa.valueProperty().set(null);
        datePicker.valueProperty().setValue(null);
        timePicker.valueProperty().setValue(null);
    }
    
    public Boolean verificarNumeros(){
        String contenido = txtTelefonoContacto.getText();
        if(contenido.matches("\\d{8}")){
            return true;
        }else{
            return false;
        }
    }
    
    public Principal getEscenarioPrincipal(){
        return escenarioPrincipal;
    }
    
    public void setEscenarioPrincipal(Principal escenarioPrincipal){
        this.escenarioPrincipal = escenarioPrincipal;
    }
    
    public void menuPrincipal(){
        escenarioPrincipal.menuPrincipal();
    }
}