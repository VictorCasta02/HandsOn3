(deffacts smartphones
  (smartphone (id 1) (marca apple) (modelo iPhone16) (color rojo) (precio 27000) (almacenamiento 128GB) (ram 8GB) (stock 100))
  (smartphone (id 2) (marca samsung) (modelo Note21) (color negro) (precio 25000) (almacenamiento 256GB) (ram 12GB) (stock 100))
  (smartphone (id 3) (marca apple) (modelo iPhone15) (color azul) (precio 22000) (almacenamiento 128GB) (ram 6GB) (stock 100))
  (smartphone (id 4) (marca google) (modelo Pixel8) (color verde) (precio 20000) (almacenamiento 128GB) (ram 8GB) (stock 100))
  (smartphone (id 5) (marca huawei) (modelo P50) (color plateado) (precio 18000) (almacenamiento 256GB) (ram 8GB) (stock 100))
  (smartphone (id 6) (marca oneplus) (modelo 12) (color negro) (precio 23000) (almacenamiento 512GB) (ram 16GB) (stock 100))
  
)

(deffacts computadores
  (computador (id 101) (marca apple) (modelo MacBookPro) (color gris) (precio 47000) (procesador M2) (ram 16GB) (stock 50))
  (computador (id 102) (marca apple) (modelo MacBookAir) (color plateado) (precio 30000) (procesador M1) (ram 8GB) (stock 50))
  (computador (id 103) (marca dell) (modelo XPS15) (color negro) (precio 35000) (procesador Intel-i7) (ram 16GB) (stock 50))
  (computador (id 104) (marca lenovo) (modelo ThinkPad) (color gris) (precio 28000) (procesador AMD-Ryzen) (ram 32GB) (stock 50))
  (computador (id 105) (marca hp) (modelo Spectre) (color azul) (precio 32000) (procesador Intel-i9) (ram 16GB) (stock 50))
)

(deffacts accesorios
  (accesorio (id 201) (tipo funda) (compatible-marca apple) (compatible-modelo iPhone16) (precio 500) (stock 200))
  (accesorio (id 202) (tipo mica) (compatible-marca apple) (compatible-modelo iPhone16) (precio 300) (stock 200))
  (accesorio (id 203) (tipo cargador) (compatible-marca samsung) (compatible-modelo Note21) (precio 800) (stock 200))
  (accesorio (id 204) (tipo auriculares) (compatible-marca google) (compatible-modelo Pixel8) (precio 1500) (stock 200))
  (accesorio (id 205) (tipo mouse) (compatible-marca apple) (compatible-modelo MacBookPro) (precio 1000) (stock 200))
  (accesorio (id 206) (tipo teclado) (compatible-marca dell) (compatible-modelo XPS15) (precio 1200) (stock 200))
)

(deffacts clientes
  (cliente (id 1) (nombre Juan Perez) (direccion "Calle Falsa 123, Ciudad") (telefono 123456789) (email juan@example.com))
  (cliente (id 2) (nombre Maria Lopez) (direccion "Avenida Siempre Viva 742, Pueblo") (telefono 987654321) (email maria@example.com))
  (cliente (id 3) (nombre Carlos Gomez) (direccion "Boulevard de los Sueños 456, Villa") (telefono 555555555) (email carlos@example.com))
  (cliente (id 4) (nombre Ana Martinez) (direccion "Ruta 66, Km 10") (telefono 111222333) (email ana@example.com))
  (cliente (id 5) (nombre Luis Rodriguez) (direccion "Plaza Central 1, Centro") (telefono 444555666) (email luis@example.com))
)

(deffacts tarjetas
  (tarjeta (id 1) (cliente-id 1) (banco banamex) (grupo visa) (exp-date 01-12-25))
  (tarjeta (id 2) (cliente-id 1) (banco liverpool) (grupo visa) (exp-date 01-12-26))
  (tarjeta (id 3) (cliente-id 2) (banco bbva) (grupo mastercard) (exp-date 05-05-24))
  (tarjeta (id 4) (cliente-id 3) (banco banamex) (grupo visa) (exp-date 10-10-25))
  (tarjeta (id 5) (cliente-id 4) (banco hsbc) (grupo americanexpress) (exp-date 12-31-23))
)

(deffacts ordenes
  (orden (numero 1) (cliente-id 1) (metodo-pago tarjeta) (tarjeta-banco bbva) (tarjeta-grupo visa))
  (orden (numero 2) (cliente-id 2) (metodo-pago efectivo))
  (orden (numero 3) (cliente-id 3) (metodo-pago tarjeta) (tarjeta-banco liverpool) (tarjeta-grupo visa))
  (orden (numero 4) (cliente-id 1) (metodo-pago efectivo))
)

(deffacts line-items
  (line-item (orden-numero 1) (product-type smartphone) (product-id 1) (cantidad 1))
  (line-item (orden-numero 2) (product-type computador) (product-id 102) (cantidad 1))
  (line-item (orden-numero 2) (product-type smartphone) (product-id 3) (cantidad 1))
  (line-item (orden-numero 3) (product-type smartphone) (product-id 2) (cantidad 1))
  (line-item (orden-numero 4) (product-type accesorio) (product-id 201) (cantidad 2))
  (line-item (orden-numero 1) (product-type accesorio) (product-id 202) (cantidad 1))
)

