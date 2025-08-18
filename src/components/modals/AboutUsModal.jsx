import Modal from '../Modal'
import { Users, Target, Award, Heart } from 'lucide-react'

const AboutUsModal = ({ isOpen, onClose }) => {
  return (
    <Modal isOpen={isOpen} onClose={onClose} title="Sobre Nosotros">
      <div className="space-y-6">
        {/* Hero Section */}
        <div className="text-center">
          <h3 className="text-2xl font-bold text-gray-900 dark:text-white mb-4">
            Tu Tienda Online de Confianza
          </h3>
          <p className="text-gray-600 dark:text-gray-300 text-lg">
            Desde 2024, hemos estado comprometidos con brindar la mejor experiencia de compra online
          </p>
        </div>

        {/* Mission & Vision */}
        <div className="grid md:grid-cols-2 gap-6">
          <div className="bg-blue-50 dark:bg-blue-900/20 p-6 rounded-lg">
            <Target className="w-8 h-8 text-blue-600 dark:text-blue-400 mb-3" />
            <h4 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
              Nuestra Misión
            </h4>
            <p className="text-gray-600 dark:text-gray-300">
              Facilitar el acceso a productos de calidad a través de una plataforma digital innovadora y fácil de usar.
            </p>
          </div>
          
          <div className="bg-green-50 dark:bg-green-900/20 p-6 rounded-lg">
            <Award className="w-8 h-8 text-green-600 dark:text-green-400 mb-3" />
            <h4 className="text-lg font-semibold text-gray-900 dark:text-white mb-2">
              Nuestra Visión
            </h4>
            <p className="text-gray-600 dark:text-gray-300">
              Ser la plataforma líder en comercio electrónico, reconocida por la excelencia en servicio al cliente.
            </p>
          </div>
        </div>

        {/* Values */}
        <div>
          <h4 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Nuestros Valores
          </h4>
          <div className="grid md:grid-cols-3 gap-4">
            <div className="text-center p-4">
              <Users className="w-8 h-8 text-gray-600 dark:text-gray-400 mx-auto mb-2" />
              <h5 className="font-medium text-gray-900 dark:text-white">Comunidad</h5>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Construimos relaciones duraderas con nuestros clientes
              </p>
            </div>
            
            <div className="text-center p-4">
              <Award className="w-8 h-8 text-gray-600 dark:text-gray-400 mx-auto mb-2" />
              <h5 className="font-medium text-gray-900 dark:text-white">Calidad</h5>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Solo ofrecemos productos que cumplen nuestros estándares
              </p>
            </div>
            
            <div className="text-center p-4">
              <Heart className="w-8 h-8 text-gray-600 dark:text-gray-400 mx-auto mb-2" />
              <h5 className="font-medium text-gray-900 dark:text-white">Pasión</h5>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Amamos lo que hacemos y se refleja en nuestro servicio
              </p>
            </div>
          </div>
        </div>

        {/* Stats */}
        <div className="bg-gray-50 dark:bg-gray-700/50 p-6 rounded-lg">
          <h4 className="text-lg font-semibold text-gray-900 dark:text-white mb-4 text-center">
            Números que Hablan
          </h4>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-center">
            <div>
              <div className="text-2xl font-bold text-blue-600 dark:text-blue-400">1000+</div>
              <div className="text-sm text-gray-600 dark:text-gray-300">Clientes Satisfechos</div>
            </div>
            <div>
              <div className="text-2xl font-bold text-green-600 dark:text-green-400">500+</div>
              <div className="text-sm text-gray-600 dark:text-gray-300">Productos</div>
            </div>
            <div>
              <div className="text-2xl font-bold text-purple-600 dark:text-purple-400">24/7</div>
              <div className="text-sm text-gray-600 dark:text-gray-300">Soporte</div>
            </div>
            <div>
              <div className="text-2xl font-bold text-orange-600 dark:text-orange-400">99%</div>
              <div className="text-sm text-gray-600 dark:text-gray-300">Satisfacción</div>
            </div>
          </div>
        </div>

        {/* Team */}
        <div>
          <h4 className="text-lg font-semibold text-gray-900 dark:text-white mb-4">
            Nuestro Equipo
          </h4>
          <p className="text-gray-600 dark:text-gray-300 mb-4">
            Contamos con un equipo apasionado y experimentado que trabaja día a día para mejorar tu experiencia de compra.
          </p>
          <div className="grid md:grid-cols-3 gap-4">
            <div className="text-center p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
              <div className="w-16 h-16 bg-blue-100 dark:bg-blue-900/30 rounded-full mx-auto mb-3 flex items-center justify-center">
                <Users className="w-8 h-8 text-blue-600 dark:text-blue-400" />
              </div>
              <h5 className="font-medium text-gray-900 dark:text-white">Equipo de Desarrollo</h5>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Innovación constante en tecnología
              </p>
            </div>
            
            <div className="text-center p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
              <div className="w-16 h-16 bg-green-100 dark:bg-green-900/30 rounded-full mx-auto mb-3 flex items-center justify-center">
                <Heart className="w-8 h-8 text-green-600 dark:text-green-400" />
              </div>
              <h5 className="font-medium text-gray-900 dark:text-white">Atención al Cliente</h5>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Soporte personalizado y eficiente
              </p>
            </div>
            
            <div className="text-center p-4 bg-gray-50 dark:bg-gray-700/50 rounded-lg">
              <div className="w-16 h-16 bg-purple-100 dark:bg-purple-900/30 rounded-full mx-auto mb-3 flex items-center justify-center">
                <Award className="w-8 h-8 text-purple-600 dark:text-purple-400" />
              </div>
              <h5 className="font-medium text-gray-900 dark:text-white">Control de Calidad</h5>
              <p className="text-sm text-gray-600 dark:text-gray-300">
                Rigurosos estándares de calidad
              </p>
            </div>
          </div>
        </div>
      </div>
    </Modal>
  )
}

export default AboutUsModal
