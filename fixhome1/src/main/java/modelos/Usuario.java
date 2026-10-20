package modelos;

import java.time.LocalDateTime;

public class Usuario {
    private int id;
    private String nombre;
    private String correo;
    private String telefono;
    private String tipoUsuario;
    private LocalDateTime fechaRe;

    public Usuario() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public String getTipoUsuario() { return tipoUsuario; }
    public void setTipoUsuario(String tipoUsuario) { this.tipoUsuario = tipoUsuario; }
    public LocalDateTime getFechaRe() { return fechaRe; }
    public void setFechaRe(LocalDateTime fechaRe) { this.fechaRe = fechaRe; }
}