import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/shared/confirm_message.dart';
import 'package:targetly/ui/shared/dialog.dart';

class ClientCommentdialog extends StatefulWidget {
  const ClientCommentdialog({super.key, required this.client});
  final ClinetModel client;

  @override
  State<ClientCommentdialog> createState() => _ClientCommentdialogState();
}

class _ClientCommentdialogState extends State<ClientCommentdialog> {
  final TextEditingController _controller = TextEditingController();
  int? _editingIndex;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF7F73E6).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.comment, color: Color(0xFF7F73E6)),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${'Comments'.tr()} - ${widget.client.clinetname}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),

          // Comments list
          widget.client.comments.isEmpty
              ? Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        Icon(
                          Icons.comment_outlined,
                          size: 40,
                          color: Colors.grey.shade300,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'No comments yet'.tr(),
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : ConstrainedBox(
                  constraints: const BoxConstraints(maxHeight: 200),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: widget.client.comments.length,
                    itemBuilder: (context, index) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 8),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.grey.shade200),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 12,
                              backgroundColor: const Color(0xFF7F73E6),
                              child: Text(
                                '${index + 1}',
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(widget.client.comments[index]),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.edit,
                                size: 16,
                                color: Colors.blue,
                              ),
                              onPressed: () {
                                setState(() {
                                  _editingIndex = index;
                                  _controller.text =
                                      widget.client.comments[index];
                                });
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.delete,
                                size: 16,
                                color: Colors.red,
                              ),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (dialogContext) => ConfirmMessage(
                                    onConfirm: () async {
                                      Navigator.pop(dialogContext);
                                      await context
                                          .read<ClinetCubit>()
                                          .deleteComment(widget.client, index);
                                      setState(() {});
                                    },
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

          const SizedBox(height: 12),
          const Divider(),
          const SizedBox(height: 12),

          // Add/Edit field
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    hintText: _editingIndex != null
                        ? 'Edit comment'.tr()
                        : 'Add comment'.tr(),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {
                  if (_controller.text.trim().isEmpty) return;
                  if (_editingIndex != null) {
                    context.read<ClinetCubit>().editComment(
                      widget.client,
                      _editingIndex!,
                      _controller.text.trim(),
                    );
                    setState(() => _editingIndex = null);
                  } else {
                    context.read<ClinetCubit>().addComment(
                      widget.client,
                      _controller.text.trim(),
                    );
                    setState(() {});
                  }
                  _controller.clear();
                },
                style: IconButton.styleFrom(
                  backgroundColor: const Color(0xFF7F73E6),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: Icon(_editingIndex != null ? Icons.check : Icons.add),
              ),
            ],
          ),

          const SizedBox(height: 16),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Close'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
