resource "azurerm_lb_probe" "http_probe" {
  loadbalancer_id = module.lb.id
  name            = "http-probe"
  port            = 80

  depends_on = [
    module.lb
  ]
}

resource "azurerm_lb_rule" "http_rule" {
  loadbalancer_id                = module.lb.id
  name                           = "http-rule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  frontend_ip_configuration_name = module.lb.frontend_ip_configuration_name
  backend_address_pool_ids       = [module.lb.blue_lb_pool_id]
  probe_id                       = azurerm_lb_probe.http_probe.id

  depends_on = [
    azurerm_lb_probe.http_probe,
    module.lb
  ]
}