import Modal from '../Modal'
import { Shield, FileText, AlertTriangle, CheckCircle } from 'lucide-react'

const TermsModal = ({ isOpen, onClose }) => {
  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Términos y Condiciones">
      <div className="space-y-6">
        {/* Introduction */}
        <div className="bg-blue-50 dark:bg-blue-900/20 p-4 rounded-lg">
          <div className="flex items-center space-x-2 mb-2">
            <Shield className="w-5 h-5 text-blue-600 dark:text-blue-400" />
            <span className="font-medium text-blue-800 dark:text-blue-200">Información Legal</span>
          </div>
          <p className="text-blue-700 dark:text-blue-300 text-sm">
            Al utilizar nuestros servicios, aceptas estos términos y condiciones. Te recomendamos leerlos cuidadosamente.
          </p>
        </div>

        {/* General Terms */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 flex items-center">
            <FileText className="w-5 h-5 mr-2 text-gray-600 dark:text-gray-400" />
            Términos Generales
          </h3>
          <div className="space-y-3">
            <div className="flex items-start space-x-3">
              <CheckCircle className="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Uso del Servicio</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Nuestros servicios están disponibles para uso personal y comercial legítimo. No se permite el uso indebido o fraudulento.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <CheckCircle className="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Edad Mínima</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Debes tener al menos 18 años para crear una cuenta y realizar compras. Los menores deben estar supervisados por un adulto.
                </p>
              </div>
            </div>
            
            <div className="flex items-start space-x-3">
              <CheckCircle className="w-5 h-5 text-green-500 mt-0.5 flex-shrink-0" />
              <div>
                <h4 className="font-medium text-gray-900 dark:text-white">Cuenta de Usuario</h4>
                <p className="text-sm text-gray-600 dark:text-gray-300">
                  Eres responsable de mantener la confidencialidad de tu cuenta y contraseña. Notifica inmediatamente cualquier uso no autorizado.
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Product Terms */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Productos y Servicios
          </h3>
          <div className="space-y-3">
            <div className="border-l-4 border-blue-500 pl-4">
              <h4 className="font-medium text-gray-900 dark:text-white">Descripción de Productos</h4>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Nos esforzamos por proporcionar descripciones precisas de los productos. Las imágenes son representativas y pueden variar ligeramente.
              </p>
            </div>
            
            <div className="border-l-4 border-green-500 pl-4">
              <h4 className="font-medium text-gray-900 dark:text-white">Disponibilidad</h4>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                La disponibilidad de productos puede cambiar sin previo aviso. Nos reservamos el derecho de cancelar pedidos si un producto no está disponible.
              </p>
            </div>
            
            <div className="border-l-4 border-purple-500 pl-4">
              <h4 className="font-medium text-gray-900 dark:text-white">Precios</h4>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Todos los precios están en USD y pueden cambiar sin previo aviso. Los impuestos se aplicarán según la jurisdicción correspondiente.
              </p>
            </div>
          </div>
        </div>

        {/* Payment Terms */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Pagos y Facturación
          </h3>
          <div className="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg space-y-2">
            <p className="text-sm text-gray-600 dark:text-gray-300">
              <strong>Métodos de Pago Aceptados:</strong> Tarjetas de crédito/débito, PayPal, transferencias bancarias.
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-300">
              <strong>Seguridad:</strong> Utilizamos encriptación SSL para proteger tu información de pago.
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-300">
              <strong>Facturación:</strong> Recibirás una factura electrónica por email después de cada compra exitosa.
            </p>
          </div>
        </div>

        {/* Shipping Terms */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Envío y Entrega
          </h3>
          <div className="space-y-3">
            <div className="grid md:grid-cols-2 gap-4">
              <div className="bg-green-50 dark:bg-green-900/20 p-3 rounded-lg">
                <h5 className="font-medium text-green-800 dark:text-green-200 mb-1">Envío Estándar</h5>
                <p className="text-xs text-green-700 dark:text-green-300">3-5 días hábiles</p>
              </div>
              <div className="bg-blue-50 dark:bg-blue-900/20 p-3 rounded-lg">
                <h5 className="font-medium text-blue-800 dark:text-blue-200 mb-1">Envío Express</h5>
                <p className="text-xs text-blue-700 dark:text-blue-300">24-48 horas</p>
              </div>
            </div>
            <p className="text-sm text-gray-600 dark:text-gray-300">
              Los tiempos de entrega son estimados y pueden variar según la ubicación y disponibilidad del producto.
            </p>
          </div>
        </div>

        {/* Return Policy */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Política de Devoluciones
          </h3>
          <div className="bg-yellow-50 dark:bg-yellow-900/20 p-4 rounded-lg">
            <div className="flex items-center space-x-2 mb-2">
              <AlertTriangle className="w-5 h-5 text-yellow-600 dark:text-yellow-400" />
              <span className="font-medium text-yellow-800 dark:text-yellow-200">Política de 30 Días</span>
            </div>
            <ul className="text-sm text-yellow-700 dark:text-yellow-300 space-y-1">
              <li>• Devoluciones aceptadas dentro de los 30 días posteriores a la compra</li>
              <li>• Productos deben estar en su estado original y empaquetado</li>
              <li>• Reembolso completo o cambio por producto equivalente</li>
              <li>• Gastos de envío de devolución a cargo del cliente</li>
            </ul>
          </div>
        </div>

        {/* Privacy and Data */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Privacidad y Datos
          </h3>
          <div className="space-y-3">
            <p className="text-sm text-gray-600 dark:text-gray-300">
              Recopilamos y procesamos datos personales según nuestra Política de Privacidad. Tus datos están protegidos y nunca se venden a terceros.
            </p>
            <p className="text-sm text-gray-600 dark:text-gray-300">
              Utilizamos cookies y tecnologías similares para mejorar tu experiencia de navegación y personalizar el contenido.
            </p>
          </div>
        </div>

        {/* Intellectual Property */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Propiedad Intelectual
          </h3>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Todo el contenido de este sitio web, incluyendo textos, imágenes, logos y software, está protegido por derechos de autor y otras leyes de propiedad intelectual.
          </p>
        </div>

        {/* Limitation of Liability */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Limitación de Responsabilidad
          </h3>
          <div className="bg-red-50 dark:bg-red-900/20 p-4 rounded-lg">
            <p className="text-sm text-red-700 dark:text-red-300">
              En ningún caso seremos responsables por daños indirectos, incidentales o consecuentes que resulten del uso de nuestros servicios.
            </p>
          </div>
        </div>

        {/* Changes to Terms */}
        <div>
          <h3 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Cambios en los Términos
          </h3>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Nos reservamos el derecho de modificar estos términos en cualquier momento. Los cambios entrarán en vigor inmediatamente después de su publicación.
          </p>
        </div>

        {/* Contact Information */}
        <div className="bg-gray-50 dark:bg-gray-700/50 p-4 rounded-lg text-center">
          <h4 className="font-medium text-gray-900 dark:text-white mb-2">
            ¿Tienes Preguntas sobre estos Términos?
          </h4>
          <p className="text-sm text-gray-600 dark:text-gray-300">
            Si tienes alguna duda o necesitas aclaración, no dudes en contactarnos en{' '}
            <span className="text-blue-600 dark:text-blue-400">legal@ecommerce.com</span>
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

export default TermsModal
