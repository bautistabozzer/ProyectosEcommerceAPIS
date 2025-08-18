import Modal from '../Modal'
import { Lock, Eye, Shield, Database, Users, Bell, Globe, Key } from 'lucide-react'

const PrivacyModal = ({ isOpen, onClose }) => {
  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Política de Privacidad">
      <div className="space-y-6">
        {/* Introduction */}
        <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
          <div className="flex items-center space-x-2 mb-2">
            <Lock className="w-5 h-5 text-blue-600 dark:text-blue-400" />
            <span className="font-medium text-blue-800 dark:text-blue-200">Tu Privacidad es Importante</span>
          </div>
          <p className="text-blue-700 dark:text-blue-300 text-sm">
            Esta política describe cómo recopilamos, usamos y protegemos tu información personal. Tu confianza es fundamental para nosotros.
          </p>
        </div>

        {/* Information We Collect */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
            <Database className="w-5 h-5 mr-2 text-gray-600 dark:text-gray-400" />
            Información que Recopilamos
          </h3>
          <div className="grid md:grid-cols-2 gap-4">
            <div className="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg">
              <h4 className="font-medium text-gray-900 dark:text-white mb-2 flex items-center">
                <Users className="w-4 h-4 mr-2 text-blue-600 dark:text-blue-400" />
                Información Personal
              </h4>
              <ul className="text-sm text-gray-600 dark:text-gray-300 space-y-1">
                <li>• Nombre y apellidos</li>
                <li>• Dirección de email</li>
                <li>• Número de teléfono</li>
                <li>• Dirección de envío</li>
                <li>• Información de pago</li>
              </ul>
            </div>
            
            <div className="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg">
              <h4 className="font-medium text-gray-900 dark:text-white mb-2 flex items-center">
                <Globe className="w-4 h-4 mr-2 text-green-600 dark:text-green-400" />
                Información Automática
              </h4>
              <ul className="text-sm text-gray-600 dark:text-gray-300 space-y-1">
                <li>• Dirección IP</li>
                <li>• Tipo de navegador</li>
                <li>• Páginas visitadas</li>
                <li>• Tiempo de navegación</li>
                <li>• Cookies y tecnologías similares</li>
              </ul>
            </div>
          </div>
        </div>

        {/* How We Use Information */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Cómo Utilizamos tu Información
          </h3>
          <div className="space-y-3">
            <div className="flex items-start space-x-3">
              <div className="w-8 h-8 bg-blue-100 dark:bg-blue-900/30 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                <span className="text-blue-600 dark:text-blue-400 text-sm font-bold">1</span>
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Procesamiento de Pedidos</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Para procesar y entregar tus compras, gestionar pagos y comunicarnos sobre el estado de tu pedido.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <div className="w-8 h-8 bg-green-100 dark:bg-green-900/30 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                <span className="text-green-600 dark:text-green-400 text-sm font-bold">2</span>
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Servicio al Cliente</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Para responder a tus consultas, resolver problemas y proporcionar soporte técnico.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <div className="w-8 h-8 bg-purple-100 dark:bg-purple-900/30 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                <span className="text-purple-600 dark:text-purple-400 text-sm font-bold">3</span>
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Mejora del Servicio</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Para analizar el uso del sitio, mejorar nuestros servicios y personalizar tu experiencia.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <div className="w-8 h-8 bg-orange-100 dark:bg-orange-900/30 rounded-full flex items-center justify-center flex-shrink-0 mt-0.5">
                <span className="text-orange-600 dark:text-orange-400 text-sm font-bold">4</span>
              </div>
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Comunicaciones</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Para enviar actualizaciones sobre productos, ofertas especiales y noticias relevantes (con tu consentimiento).
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Information Sharing */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Compartir Información
          </h3>
          <div className="bg-yellow-50 dark:bg-yellow-900/20 p-4 rounded-lg">
            <div className="flex items-center space-x-2 mb-2">
              <Shield className="w-5 h-5 text-yellow-600 dark:text-yellow-400" />
              <span className="font-medium text-yellow-800 dark:text-yellow-200">Nunca Vendemos tu Información</span>
            </div>
            <p className="text-sm text-yellow-700 dark:text-yellow-300 mb-3">
              Tu información personal nunca se vende, alquila o intercambia con terceros para fines comerciales.
            </p>
            <div className="space-y-2">
              <p className="text-sm text-yellow-700 dark:text-yellow-300">
                <strong>Excepciones limitadas:</strong>
              </p>
              <ul className="text-sm text-yellow-700 dark:text-yellow-300 space-y-1 ml-4">
                <li>• Proveedores de servicios (envío, pagos) bajo estrictos acuerdos de confidencialidad</li>
                <li>• Cumplimiento legal cuando sea requerido por ley</li>
                <li>• Protección de nuestros derechos y seguridad</li>
              </ul>
            </div>
          </div>
        </div>

        {/* Data Security */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Seguridad de Datos
          </h3>
          <div className="grid md:grid-cols-2 gap-4">
            <div className="bg-green-50 dark:bg-green-900/20 p-4 rounded-lg">
              <h4 className="font-medium text-green-800 dark:text-green-200 mb-2 flex items-center">
                <Key className="w-4 h-4 mr-2" />
                Encriptación
              </h4>
              <p className="text-sm text-green-700 dark:text-green-300">
                Utilizamos encriptación SSL de 256 bits para proteger la transmisión de datos sensibles.
              </p>
            </div>
            
            <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
              <h4 className="font-medium text-blue-800 dark:text-blue-200 mb-2 flex items-center">
                <Lock className="w-4 h-4 mr-2" />
                Acceso Restringido
              </h4>
              <p className="text-sm text-blue-700 dark:text-blue-300">
                Solo personal autorizado tiene acceso a tu información personal, bajo estrictos controles de seguridad.
              </p>
            </div>
          </div>
        </div>

        {/* Cookies */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Cookies y Tecnologías Similares
          </h3>
          <div className="space-y-3">
            <p className="text-sm text-gray-600 dark:text-gray-300">
              Utilizamos cookies para mejorar tu experiencia de navegación y personalizar el contenido.
            </p>
            <div className="grid md:grid-cols-3 gap-3">
              <div className="text-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                <h5 className="font-medium text-gray-900 dark:text-white text-sm">Cookies Esenciales</h5>
                <p className="text-xs text-gray-600 dark:text-gray-300">Funcionalidad básica del sitio</p>
              </div>
              <div className="text-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                <h5 className="font-medium text-gray-900 dark:text-white text-sm">Cookies de Rendimiento</h5>
                <p className="text-xs text-gray-600 dark:text-gray-300">Análisis y mejoras</p>
              </div>
              <div className="text-center p-3 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
                <h5 className="font-medium text-gray-900 dark:text-white text-sm">Cookies de Marketing</h5>
                <p className="text-xs text-gray-600 dark:text-gray-300">Publicidad personalizada</p>
              </div>
            </div>
          </div>
        </div>

        {/* Your Rights */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Tus Derechos
          </h3>
          <div className="space-y-3">
            <div className="flex items-start space-x-3">
              <Eye className="w-5 h-5 text-blue-600 dark:text-blue-400 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Acceso y Visualización</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Puedes solicitar una copia de la información personal que tenemos sobre ti.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <Key className="w-5 h-5 text-green-600 dark:text-green-400 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Corrección</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Puedes solicitar la corrección de información inexacta o incompleta.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <Bell className="w-5 h-5 text-purple-600 dark:text-purple-400 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Cancelación de Suscripciones</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Puedes cancelar las comunicaciones de marketing en cualquier momento.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <Database className="w-5 h-5 text-red-600 dark:text-red-400 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Eliminación</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Puedes solicitar la eliminación de tu información personal, sujeto a ciertas excepciones legales.
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Data Retention */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Retención de Datos
          </h3>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Conservamos tu información personal solo durante el tiempo necesario para cumplir con los propósitos descritos en esta política, 
            o según lo requiera la ley. Los datos de la cuenta se mantienen mientras tu cuenta esté activa.
          </p>
        </div>

        {/* Children's Privacy */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Privacidad de Menores
          </h3>
          <div className="bg-red-50 dark:bg-red-900/20 p-4 rounded-lg">
            <p className="text-sm text-red-700 dark:text-red-300">
              Nuestros servicios no están dirigidos a menores de 18 años. No recopilamos intencionalmente información personal de menores. 
              Si eres padre o tutor y crees que tu hijo nos ha proporcionado información personal, contáctanos inmediatamente.
            </p>
          </div>
        </div>

        {/* International Transfers */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Transferencias Internacionales
          </h3>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Tu información puede ser transferida y procesada en países diferentes al tuyo. Nos aseguramos de que estas transferencias 
            cumplan con las leyes de protección de datos aplicables y mantengan el mismo nivel de protección.
          </p>
        </div>

        {/* Changes to Policy */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Cambios en esta Política
          </h3>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Podemos actualizar esta política ocasionalmente. Te notificaremos sobre cambios significativos por email o mediante un aviso 
            prominente en nuestro sitio web. Te recomendamos revisar esta política periódicamente.
          </p>
        </div>

        {/* Contact Information */}
        <div className="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg text-center">
          <h4 className="font-medium text-gray-900 dark:text-white mb-2">
            ¿Tienes Preguntas sobre Privacidad?
          </h4>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Si tienes alguna pregunta sobre esta política o el manejo de tus datos, contáctanos en{' '}
            <span className="text-blue-600 dark:text-blue-400">privacy@ecommerce.com</span>
          </p>
        </div>

        {/* Last Updated */}
        <div className="text-center text-xs text-gray-500 dark:text-gray-400 border-t border-gray-200 dark:border-gray-600 pt-4">
          <p>Última actualización: Enero 2024</p>
          <p>Versión: 1.0</p>
        </div>
      </div>
    </Modal>
  )
}

export default PrivacyModal
