package com.ieseljust.pmdm.comptador

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import com.ieseljust.pmdm.comptador.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    private var comptador = 0

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        val view = binding.root
        setContentView(view)

        // Inicialitzem el TextView amb el comptador a 0
        binding.textViewComptador.text = comptador.toString()

        // Restaurar el valor del contador si hay un estado previamente guardado
        if (savedInstanceState != null) {
            comptador = savedInstanceState.getInt("contador", 0)
        }

        // Inicializar el TextView con el valor del contador
        binding.textViewComptador.text = comptador.toString()

        // Asociar una expresión lambda como respuesta (callback) al evento Clic sobre el botón Add
        binding.btAdd.setOnClickListener {
            comptador++
            binding.textViewComptador.text = comptador.toString()
        }

        // Restar uno al hacer clic en Resta si no es 0
        binding.btResta.setOnClickListener {
            if (comptador > 0) {
                comptador--
                binding.textViewComptador.text = comptador.toString()
            }
        }

        // Reiniciar el contador al hacer clic en Reset
        binding.btReset.setOnClickListener {
            comptador = 0
            binding.textViewComptador.text = comptador.toString()
        }
    }

    override fun onSaveInstanceState(outState: Bundle) {
        super.onSaveInstanceState(outState)
        // Guardar el valor del contador en el estado
        outState.putInt("contador", comptador)
    }
}
