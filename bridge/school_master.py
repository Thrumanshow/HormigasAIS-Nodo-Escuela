import os
import time
import threading

# Mapeo de Imaginación: Roles de Estudiantes
ROLES = {
    "01": "Stanford (La Científica - Analiza patrones)",
    "02": "Limpiadora (Mantiene el orden de logs)",
    "03": "Almacén (Organiza el conocimiento)",
    "04": "Enfermera (Vigila la salud del nodo)",
    "05": "Directora (Coordina prioridades)",
    "06": "Instructora (Enseña nuevas reglas)",
    "07": "Cuidadora (Protege la integridad)",
    "08": "Ayudante (Soporte en tareas pesadas)",
    "09": "Exploradora (Busca nuevos datos)",
    "10": "Delegada (Representa al grupo)"
}

def student_process(id, role):
    log_path = "logs/school.log"
    while True:
        with open(log_path, "a") as f:
            f.write(f"[{time.ctime()}] Estudiante {id} ({role}): Estudiando hábitos de la colonia...\n")
        time.sleep(15)

if __name__ == "__main__":
    print("🎓 Nodo-Escuela HormigasAIS: Iniciando ciclo académico...")
    for id, role in ROLES.items():
        t = threading.Thread(target=student_process, args=(id, role))
        t.daemon = True
        t.start()
    
    try:
        while True: time.sleep(1)
    except KeyboardInterrupt:
        print("\n📚 Clase terminada. Guardando currículum.")
