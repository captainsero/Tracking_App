import 'package:flutter/material.dart';
import 'package:tracking_app/core/constants/color_manager.dart';
import 'package:tracking_app/features/order_details/domain/entitty/contact_info.dart';

/// Shared card for "Pickup address" and "User address" — same shape in
/// the design (avatar, name, address, call + WhatsApp). One widget,
/// two call sites, instead of near-duplicate code for each section.
///
/// Callbacks are injected rather than calling url_launcher internally,
/// so this widget has no platform/permission dependencies of its own
/// and is trivial to test or swap later.
class ContactCard extends StatelessWidget {
  final ContactInfo contact;
  final VoidCallback? onCallTap;
  final VoidCallback? onWhatsAppTap;

  const ContactCard({
    super.key,
    required this.contact,
    this.onCallTap,
    this.onWhatsAppTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.cardBorder),
      ),
      child: Row(
        children: [
          _Avatar(url: contact.avatarUrl),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  contact.name,
                  style: TextStyle(
                    color: AppColors.grey,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        contact.address,
                        style: TextStyle(color: AppColors.black, fontSize: 13),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          _IconButton(icon: Icons.call, onTap: onCallTap),
          const SizedBox(width: 8),
          _IconButton(icon: Icons.chat_bubble, onTap: onWhatsAppTap),
        ],
      ),
    );
  }
}

class _Avatar extends StatelessWidget {
  final String? url;
  const _Avatar({this.url});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 22,
      backgroundColor: AppColors.lightPink,
      backgroundImage: url != null ? NetworkImage(url!) : null,
      child: url == null
          ? Icon(Icons.storefront, color: AppColors.primary, size: 20)
          : null,
    );
  }
}

class _IconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const _IconButton({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primary,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: AppColors.white, size: 16),
      ),
    );
  }
}
