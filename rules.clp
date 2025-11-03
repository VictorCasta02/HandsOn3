(defrule oferta-iphone16-banamex
  (orden (numero ?o) (cliente-id ?cid) (metodo-pago tarjeta) (tarjeta-banco banamex))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid))
  (smartphone (id ?pid) (marca apple) (modelo iPhone16))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Oferta aplicable: " (implode$ ?name) " puede pagar el iPhone16 a 24 meses sin intereses con Banamex." crlf)
)

(defrule oferta-note21-liverpool-visa
  (orden (numero ?o) (cliente-id ?cid) (metodo-pago tarjeta) (tarjeta-banco liverpool) (tarjeta-grupo visa))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid))
  (smartphone (id ?pid) (marca samsung) (modelo Note21))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Oferta aplicable: " (implode$ ?name) " puede pagar el Samsung Note21 a 12 meses sin intereses con Liverpool Visa." crlf)
)

(defrule vales-macbookair-iphone16-efectivo
  (orden (numero ?o) (cliente-id ?cid) (metodo-pago efectivo))
  (line-item (orden-numero ?o) (product-type computador) (product-id ?pidc))
  (computador (id ?pidc) (marca apple) (modelo MacBookAir) (precio ?precioc))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pids))
  (smartphone (id ?pids) (marca apple) (modelo iPhone16) (precio ?precios))
  (cliente (id ?cid) (nombre $?name))
  =>
  (bind ?total (+ ?precioc ?precios))
  (bind ?vales (* (div ?total 1000) 100))
  (assert (vale (id (gensym*)) (cliente-id ?cid) (valor ?vales) (motivo "Compra MacBookAir + iPhone16")))
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe " ?vales " pesos en vales por compra en efectivo." crlf)
)

(defrule descuento-accesorios-smartphone
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pids))
  (smartphone (id ?pids) (marca ?marca) (modelo ?modelo))
  (line-item (orden-numero ?o) (product-type accesorio) (product-id ?pida))
  (accesorio (id ?pida) (tipo ?tipo&funda|mica) (compatible-marca ?marca) (compatible-modelo ?modelo) (precio ?precioa))
  (cliente (id ?cid) (nombre $?name))
  =>
  (bind ?descuento (* ?precioa 0.15))
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe 15% descuento en " ?tipo " (" ?descuento " pesos menos)." crlf)
)

(defrule clasificar-cliente
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty))
  (smartphone (id ?pid) (modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (if (< ?qty 10) then
    (printout t "Clasificación: " (implode$ ?name) " es Menudista (cantidad " ?qty " de " ?modelo ")." crlf)
  else
    (printout t "Clasificación: " (implode$ ?name) " es Mayorista (cantidad " ?qty " de " ?modelo ")." crlf))
)

;; Rule 6: Update stock for smartphone orders
(defrule actualizar-stock-smartphone
  ?item <- (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty))
  ?prod <- (smartphone (id ?pid) (modelo ?modelo) (stock ?stock&:(>= ?stock ?qty)))
  =>
  (modify ?prod (stock (- ?stock ?qty)))
  (printout t "Stock actualizado: " ?modelo " ahora tiene " (- ?stock ?qty) " unidades." crlf)
)

(defrule alerta-stock-insuficiente
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty))
  (smartphone (id ?pid) (modelo ?modelo) (stock ?stock&:(< ?stock ?qty)))
  =>
  (printout t "Alerta: Stock insuficiente para " ?modelo ". Requerido: " ?qty ", Disponible: " ?stock "." crlf)
)

(defrule recomendar-accesorios
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty))
  (smartphone (id ?pid) (marca ?marca) (modelo ?modelo))
  (accesorio (tipo ?tipo&funda|mica) (compatible-marca ?marca) (compatible-modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Recomendación: " (implode$ ?name) ", considera comprar una " ?tipo " para tu " ?modelo "." crlf)
)

(defrule descuento-mayorista
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty&:(> ?qty 10)))
  (smartphone (id ?pid) (modelo ?modelo) (precio ?precio))
  (cliente (id ?cid) (nombre $?name))
  =>
  (bind ?descuento (* (* ?precio ?qty) 0.1))
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe 10% descuento por compra mayorista de " ?qty " " ?modelo " (" ?descuento " pesos menos)." crlf)
)

(defrule garantia-extendida
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty&:(> ?qty 10)))
  (smartphone (id ?pid) (modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Recomendación: " (implode$ ?name) ", considera garantía extendida para tu compra mayorista de " ?modelo "." crlf)
)

(defrule vale-compra-grande
  (orden (numero ?o) (cliente-id ?cid) (total ?total&:(> ?total 60000)))
  (cliente (id ?cid) (nombre $?name))
  =>
  (assert (vale (id (gensym*)) (cliente-id ?cid) (valor 1000) (motivo "Compra grande")))
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe 1000 pesos en vale por compra mayor a 60,000 pesos." crlf)
)

(defrule notificar-compra-cantidad
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty&:(> ?qty 2)))
  (smartphone (id ?pid) (modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Notificación: " (implode$ ?name) " compró " ?qty " unidades de " ?modelo "." crlf)
)

(defrule envio-gratis
  (orden (numero ?o) (cliente-id ?cid) (total ?total&:(> ?total 50000)))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Oferta aplicable: " (implode$ ?name) " recibe envío gratis por compra mayor a 50,000 pesos." crlf)
)

(defrule recomendar-applecare
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid))
  (smartphone (id ?pid) (marca apple) (modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Recomendación: " (implode$ ?name) ", considera AppleCare para tu " ?modelo "." crlf)
)

(defrule descuento-color-rojo
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid))
  (smartphone (id ?pid) (color rojo) (precio ?precio) (modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (bind ?descuento (* ?precio 0.05))
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe 5% descuento por " ?modelo " rojo (" ?descuento " pesos menos)." crlf)
)

(defrule alerta-compra-alta
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type ?type) (product-id ?pid))
  (or
    (and
      (test (eq ?type smartphone))
      (smartphone (id ?pid) (precio ?precio&:(> ?precio 40000)))
    )
    (and
      (test (eq ?type computador))
      (computador (id ?pid) (precio ?precio&:(> ?precio 40000)))
    )
    (and
      (test (eq ?type accesorio))
      (accesorio (id ?pid) (precio ?precio&:(> ?precio 40000)))
    )
  )
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Notificación: " (implode$ ?name) " ha comprado un producto de alto valor (" ?precio " pesos)." crlf)
)

(defrule descuento-lealtad
  ?o1 <- (orden (numero ?n1) (cliente-id ?cid))
  ?o2 <- (orden (numero ?n2&:(neq ?n1 ?n2)) (cliente-id ?cid))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe 10% descuento por ser cliente recurrente." crlf)
)

(defrule tarjeta-expirada
  (orden (numero ?o) (cliente-id ?cid) (metodo-pago tarjeta))
  (tarjeta (cliente-id ?cid) (exp-date ?date))
  (test (< (str-compare ?date "2025-10-24") 0))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Notificación: " (implode$ ?name) ", tu tarjeta ha expirado." crlf)
)

(defrule recomendar-compra-mayorista
  (orden (numero ?o) (cliente-id ?cid))
  (line-item (orden-numero ?o) (product-type smartphone) (product-id ?pid) (cantidad ?qty&:(< ?qty 10)))
  (smartphone (id ?pid) (modelo ?modelo))
  (cliente (id ?cid) (nombre $?name))
  =>
  (printout t "Recomendación: " (implode$ ?name) ", compra 10 o más " ?modelo " para descuentos mayoristas." crlf)
)

(defrule vale-por-referencia
  (orden (numero ?o) (cliente-id ?cid))
  (cliente (id ?cid) (nombre $?name))
  =>
  (assert (vale (id (gensym*)) (cliente-id ?cid) (valor 500) (motivo "Referencia de amigo")))
  (printout t "Descuento aplicable: " (implode$ ?name) " recibe 500 pesos en vale por referir a un amigo." crlf)
)