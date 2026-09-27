import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../theme/app_theme.dart';
import '../../../widgets/custom_icon_widget.dart';

class ListingFormWidget extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final bool isTablet;

  const ListingFormWidget({
    super.key,
    required this.formKey,
    required this.isTablet,
  });

  @override
  State<ListingFormWidget> createState() => _ListingFormWidgetState();
}

class _ListingFormWidgetState extends State<ListingFormWidget> {
  // TODO: Replace with [Riverpod/Bloc] for production
  final _marqueController = TextEditingController();
  final _modeleController = TextEditingController();
  final _anneeController = TextEditingController();
  final _prixController = TextEditingController();
  final _descController = TextEditingController();
  String? _selectedVille;
  String? _selectedCarburant;
  String? _selectedBoite;

  static const List<String> _villes = [
    'Casablanca',
    'Rabat',
    'Marrakech',
    'Tanger',
    'Fès',
    'Agadir',
    'Meknès',
    'Oujda',
    'Kenitra',
    'Tétouan',
  ];

  static const List<String> _carburants = [
    'Diesel',
    'Essence',
    'Hybride',
    'Électrique',
    'GPL',
  ];

  static const List<String> _boites = [
    'Manuelle',
    'Automatique',
    'Semi-automatique',
  ];

  static const List<String> _marques = [
    'Dacia',
    'Renault',
    'Peugeot',
    'Toyota',
    'Hyundai',
    'Kia',
    'Volkswagen',
    'Ford',
    'Mercedes-Benz',
    'BMW',
    'Audi',
    'Citroën',
    'Fiat',
    'Seat',
    'Opel',
  ];

  String? _selectedMarque;

  @override
  void dispose() {
    _marqueController.dispose();
    _modeleController.dispose();
    _anneeController.dispose();
    _prixController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSection(
          icon: 'directions_car',
          title: 'Informations du véhicule',
          child: widget.isTablet
              ? _buildTwoColumnFields([
                  _buildMarqueDropdown(),
                  _buildModeleField(),
                  _buildAnneeField(),
                  _buildCarburantDropdown(),
                  _buildBoiteDropdown(),
                ])
              : Column(
                  children: [
                    _buildMarqueDropdown(),
                    const SizedBox(height: 14),
                    _buildModeleField(),
                    const SizedBox(height: 14),
                    _buildAnneeField(),
                    const SizedBox(height: 14),
                    _buildCarburantDropdown(),
                    const SizedBox(height: 14),
                    _buildBoiteDropdown(),
                  ],
                ),
        ),
        const SizedBox(height: 12),
        _buildSection(
          icon: 'payments',
          title: 'Prix',
          child: _buildPrixField(),
        ),
        const SizedBox(height: 12),
        _buildSection(
          icon: 'location_on',
          title: 'Localisation',
          child: _buildVilleDropdown(),
        ),
        const SizedBox(height: 12),
        _buildSection(
          icon: 'description',
          title: 'Description',
          child: _buildDescriptionField(),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildSection({
    required String icon,
    required String title,
    required Widget child,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(13),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(
                iconName: icon,
                color: AppTheme.primary,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: GoogleFonts.dmSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppTheme.navy,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          child,
        ],
      ),
    );
  }

  Widget _buildTwoColumnFields(List<Widget> fields) {
    final rows = <Widget>[];
    for (int i = 0; i < fields.length; i += 2) {
      final isLast = i + 1 >= fields.length;
      rows.add(
        Row(
          children: [
            Expanded(child: fields[i]),
            if (!isLast) ...[
              const SizedBox(width: 12),
              Expanded(child: fields[i + 1]),
            ],
          ],
        ),
      );
      if (i + 2 < fields.length) rows.add(const SizedBox(height: 14));
    }
    return Column(children: rows);
  }

  Widget _buildMarqueDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Marque *'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedMarque,
          decoration: _inputDecoration('Sélectionner la marque'),
          items: _marques
              .map((m) => DropdownMenuItem(value: m, child: Text(m)))
              .toList(),
          onChanged: (val) => setState(() => _selectedMarque = val),
          validator: (val) =>
              val == null ? 'Veuillez sélectionner une marque' : null,
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildModeleField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Modèle *'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _modeleController,
          decoration: _inputDecoration('Sélectionner le modèle'),
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          validator: (val) => (val == null || val.trim().isEmpty)
              ? 'Veuillez entrer le modèle'
              : null,
        ),
      ],
    );
  }

  Widget _buildAnneeField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Année *'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _anneeController,
          decoration: _inputDecoration('Ex. 2020'),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(4),
          ],
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Veuillez entrer l\'année';
            }
            final year = int.tryParse(val);
            if (year == null || year < 1990 || year > 2026) {
              return 'Année invalide (1990–2026)';
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildCarburantDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Carburant'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedCarburant,
          decoration: _inputDecoration('Tous les carburants'),
          items: _carburants
              .map((c) => DropdownMenuItem(value: c, child: Text(c)))
              .toList(),
          onChanged: (val) => setState(() => _selectedCarburant = val),
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildBoiteDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Boîte de vitesse'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedBoite,
          decoration: _inputDecoration('Toutes les boîtes'),
          items: _boites
              .map((b) => DropdownMenuItem(value: b, child: Text(b)))
              .toList(),
          onChanged: (val) => setState(() => _selectedBoite = val),
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildPrixField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Prix *'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _prixController,
          decoration: _inputDecoration('Ex. 150000').copyWith(
            suffixText: 'DH',
            suffixStyle: GoogleFonts.dmSans(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppTheme.primary,
            ),
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          validator: (val) {
            if (val == null || val.trim().isEmpty) {
              return 'Veuillez entrer le prix';
            }
            final price = int.tryParse(val);
            if (price == null || price <= 0) {
              return 'Prix invalide';
            }
            return null;
          },
        ),
        const SizedBox(height: 8),
        Text(
          'Entrez le prix en Dirhams marocains (DH)',
          style: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.mutedText),
        ),
      ],
    );
  }

  Widget _buildVilleDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Ville *'),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          initialValue: _selectedVille,
          decoration: _inputDecoration('Sélectionner la ville'),
          items: _villes
              .map((v) => DropdownMenuItem(value: v, child: Text(v)))
              .toList(),
          onChanged: (val) => setState(() => _selectedVille = val),
          validator: (val) =>
              val == null ? 'Veuillez sélectionner une ville' : null,
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          dropdownColor: Colors.white,
          icon: const Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.mutedText,
          ),
        ),
      ],
    );
  }

  Widget _buildDescriptionField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Description'),
        const SizedBox(height: 6),
        TextFormField(
          controller: _descController,
          decoration: _inputDecoration(
            'Décrivez votre voiture : état, options, historique...',
          ).copyWith(alignLabelWithHint: true),
          maxLines: 5,
          minLines: 4,
          style: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.navy),
          textAlignVertical: TextAlignVertical.top,
          maxLength: 1000,
          buildCounter:
              (
                context, {
                required currentLength,
                required isFocused,
                maxLength,
              }) {
                return Text(
                  '$currentLength/$maxLength',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: AppTheme.mutedText,
                  ),
                );
              },
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: AppTheme.primary.withAlpha(15),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: AppTheme.primary.withAlpha(51)),
          ),
          child: Row(
            children: [
              Icon(
                Icons.tips_and_updates_outlined,
                color: AppTheme.primary,
                size: 16,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Conseil : Mentionnez l\'état général, les options, le kilométrage et l\'historique d\'entretien.',
                  style: GoogleFonts.dmSans(
                    fontSize: 11,
                    color: AppTheme.primary,
                    height: 1.5,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFieldLabel(String label) {
    final isRequired = label.contains('*');
    return RichText(
      text: TextSpan(
        text: label.replaceAll(' *', ''),
        style: GoogleFonts.dmSans(
          fontSize: 13,
          fontWeight: FontWeight.w600,
          color: AppTheme.navy,
        ),
        children: isRequired
            ? [
                TextSpan(
                  text: ' *',
                  style: GoogleFonts.dmSans(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppTheme.error,
                  ),
                ),
              ]
            : [],
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: GoogleFonts.dmSans(fontSize: 14, color: AppTheme.mutedText),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.primary, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.error, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppTheme.error, width: 2),
      ),
      errorStyle: GoogleFonts.dmSans(fontSize: 11, color: AppTheme.error),
    );
  }
}
