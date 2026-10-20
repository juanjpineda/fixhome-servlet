package modelos;

import java.time.LocalDateTime;

public class Servicio {
    private int id;
    private String nombre;
    private String descripcion;
    private double precio;
    private LocalDateTime fechaRe;

    public Servicio() { }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getDescripcion() { return descripcion; }
    public void setDescripcion(String descripcion) { this.descripcion = descripcion; }
    public double getPrecio() { return precio; }
    public void setPrecio(double precio) { this.precio = precio; }
    public LocalDateTime getFechaRe() { return fechaRe; }
    public void setFechaRe(LocalDateTime fechaRe) { this.fechaRe = fechaRe; }
}