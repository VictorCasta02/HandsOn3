(deftemplate smartphone
  (slot id)
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio)
  (slot almacenamiento)
  (slot ram)
  (slot stock (default 100)) ; Added stock slot for tracking inventory
)

(deftemplate computador
  (slot id)
  (slot marca)
  (slot modelo)
  (slot color)
  (slot precio)
  (slot procesador)
  (slot ram)
  (slot stock (default 50))
)

(deftemplate accesorio
  (slot id)
  (slot tipo)
  (slot compatible-marca)
  (slot compatible-modelo)
  (slot precio)
  (slot stock (default 200))
)

(deftemplate cliente
  (slot id)
  (multislot nombre)
  (multislot direccion)
  (slot telefono)
  (slot email)
)

(deftemplate orden
  (slot numero)
  (slot cliente-id)
  (slot metodo-pago)
  (slot tarjeta-banco)
  (slot tarjeta-grupo)
  (slot total (default 0))
)

(deftemplate line-item
  (slot orden-numero)
  (slot product-type)
  (slot product-id)
  (slot cantidad (default 1))
)

(deftemplate tarjeta
  (slot id)
  (slot cliente-id)
  (slot banco)
  (slot grupo)
  (slot exp-date)
)

(deftemplate vale
  (slot id)
  (slot cliente-id)
  (slot valor)
)