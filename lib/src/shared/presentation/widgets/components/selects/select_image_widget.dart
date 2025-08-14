import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../utils/styles/colors/colors_base.dart';
import '../../../utils/styles/colors/colors_context.dart';
import 'modal_select_image_widget.dart';

enum SelectImageType { profile, picture }

class SelectImageWidget extends StatefulWidget {
  final String? imagePath;
  final void Function(XFile?)? onImageSelected;
  final Widget? Function(
    BuildContext context,
    ImageProvider? image,
    bool hasImage,
  )?
  builder;
  final SelectImageType type;

  const SelectImageWidget({
    super.key,
    this.imagePath,
    this.onImageSelected,
    this.builder,
    this.type = SelectImageType.profile,
  });

  /// Constructor para imagen de perfil (CircleAvatar por defecto)
  const SelectImageWidget.profile({
    super.key,
    this.imagePath,
    this.onImageSelected,
    this.builder,
  }) : type = SelectImageType.profile;

  /// Constructor para imagen general (Container rectangular por defecto)
  const SelectImageWidget.picture({
    super.key,
    this.imagePath,
    this.onImageSelected,
    this.builder,
  }) : type = SelectImageType.picture;

  @override
  State<SelectImageWidget> createState() => _SelectImageWidgetState();
}

class _SelectImageWidgetState extends State<SelectImageWidget> {
  XFile? _selectedImage;

  Future<void> _pickImage(BuildContext context) async {
    final picker = ImagePicker();
    final source = await showSelectImage(context);

    if (source != null) {
      final pickedImage = await picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = pickedImage;
        });
        widget.onImageSelected?.call(pickedImage);
      }
    }
  }

  void _deleteImage() {
    setState(() {
      _selectedImage = null;
    });
    widget.onImageSelected?.call(null);
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = _selectedImage != null || widget.imagePath != null;
    final imageProvider = _getImageProvider();

    return Stack(
      alignment: Alignment.center,
      children: [
        widget.builder != null
            ? widget.builder!(context, imageProvider, hasImage)!
            : _buildDefaultWidget(imageProvider, hasImage),
        // Botones de editar y borrar en la esquina superior derecha
        Positioned(
          top: 0,
          right: 0,
          child: Column(
            children: [
              // Botón de editar
              GestureDetector(
                onTap: () => _pickImage(context),
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: context.colors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.edit,
                    color: AppColors.of(context).specificContentInverse,
                    size: 20,
                  ),
                ),
              ),
              // Botón de borrar (solo si hay imagen)
              if (hasImage) const SizedBox(height: 8),
              if (hasImage)
                GestureDetector(
                  onTap: _deleteImage,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.of(context).specificSemanticError,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete,
                      color: AppColors.of(context).specificContentInverse,
                      size: 20,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  /// Construye el widget por defecto según el tipo
  Widget _buildDefaultWidget(ImageProvider? imageProvider, bool hasImage) {
    switch (widget.type) {
      case SelectImageType.profile:
        return _buildProfileWidget(imageProvider);
      case SelectImageType.picture:
        return _buildPictureWidget(imageProvider);
    }
  }

  /// Widget por defecto para perfil (CircleAvatar)
  Widget _buildProfileWidget(ImageProvider? imageProvider) {
    return CircleAvatar(
      radius: 60,
      backgroundColor: Colors.grey[300],
      backgroundImage: imageProvider,
      child: imageProvider == null
          ? Icon(
              Icons.person,
              size: 60,
              color: context.colors.specificContentMid,
            )
          : null,
    );
  }

  /// Widget por defecto para imagen general (Container rectangular)
  Widget _buildPictureWidget(ImageProvider? imageProvider) {
    return Container(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        color: context.colors.specificSurfaceExtraLow,
        border: Border.all(
          color: context.colors.specificBorderLow,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(12),
        image: imageProvider != null
            ? DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imageProvider == null
          ? Icon(
              Icons.image,
              size: 48,
              color: context.colors.specificContentMid,
            )
          : null,
    );
  }

  // Determina qué imagen mostrar (seleccionada, proporcionada o ninguna)
  ImageProvider? _getImageProvider() {
    if (_selectedImage != null) {
      return FileImage(File(_selectedImage!.path));
    } else if (widget.imagePath != null) {
      if (widget.imagePath!.startsWith('http')) {
        return NetworkImage(widget.imagePath!);
      } else {
        return FileImage(File(widget.imagePath!));
      }
    }
    return null;
  }
}
