import 'package:flutter/material.dart';

import 'colors_base.dart';
import 'colors_context.dart';
import 'colors_provider.dart';

/// Ejemplo completo mostrando todas las formas de usar colores automáticos
class AutomaticColorsExample extends StatelessWidget {
  const AutomaticColorsExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Colores Automáticos'),
        // Opción 1: Usando AppColors.of(context)
        backgroundColor: AppColors.of(context).primary,
        foregroundColor: AppColors.of(context).specificContentInverse,
      ),
      body: AppColorsProvider(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Opción 1: AppColors.of(context)
              _ExampleSection(
                title: 'Opción 1: AppColors.of(context)',
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.of(context).specificSurfaceLow,
                    border: Border.all(
                      color: AppColors.of(context).specificBorderLow,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Usando AppColors.of(context).primary',
                    style: TextStyle(
                      color: AppColorsResolver.current.background,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Opción 2: Extension context.colors
              _ExampleSection(
                title: 'Opción 2: context.colors (Extension)',
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: context.colors.specificSurfaceHigh,
                    border: Border.all(
                      color: context.colors.specificBorderMid,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Usando context.colors.secondary',
                    style: TextStyle(
                      color: context.colors.specificContentHigh,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Opción 3: InheritedWidget
              _ExampleSection(
                title: 'Opción 3: AppColorsInherited',
                child: Builder(
                  builder: (context) {
                    final colors = AppColorsInherited.of(context);
                    return Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        gradient: colors.gradientPrimary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Usando AppColorsInherited',
                        style: TextStyle(
                          color: colors.specificContentInverse,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Botones de ejemplo
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colors.primary,
                        foregroundColor: context.colors.specificContentInverse,
                      ),
                      child: const Text('Botón Primario'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.of(context).secondary,
                        side: BorderSide(
                          color: AppColors.of(context).secondary,
                        ),
                      ),
                      child: const Text('Botón Secundario'),
                    ),
                  ),
                ],
              ),

              const Spacer(),

              // Indicador de tema actual
              Card(
                color: context.colors.specificSurfaceMid,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(
                        Theme.of(context).brightness == Brightness.dark
                            ? Icons.dark_mode
                            : Icons.light_mode,
                        color: context.colors.specificContentHigh,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Tema: ${Theme.of(context).brightness == Brightness.dark ? "Oscuro" : "Claro"}',
                        style: TextStyle(
                          color: context.colors.specificContentHigh,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExampleSection extends StatelessWidget {
  final String title;
  final Widget child;

  const _ExampleSection({
    required this.title,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: context.colors.specificContentHigh,
          ),
        ),
        const SizedBox(height: 8),
        child,
      ],
    );
  }
}
