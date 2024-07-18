import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final String? header;
  final String? title;
  final String? sub;
  final String? status;
  final String? amount;
  final bool? success;
  final bool? download;
  
  const ListItem({super.key, 
    this.header,
    this.title,
    this.sub,
    this.status,
    this.amount,
    this.success,
    this.download,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: header!=null,
          child: Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(bottom: 10, top: 10, left: 16, right: 16),
              child: Text(header??'', style: const TextStyle(
                                        fontFamily: "Slussen",
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12,
                                        color: Color(0xFFFFFFFF)
                                      ),
            ),
          ),
        ),
        Visibility(
          visible: header==null,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0x33201A3F),
              ),
            child: Container(
              margin: const EdgeInsets.only(bottom: 10, left: 16, right: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: const Color(0x1AFFFFFF),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
            
                  CircleAvatar(
                    radius: 26,
                    backgroundColor: const Color(0x0DFFFFFF),
                    child: Icon( success??false ?Icons.download_rounded: Icons.upload_rounded, color: success??false ? const Color(0xFF2EBB17) : const Color(0xFFFF5361),),
                  ),
            
                  Expanded(child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title??'', style: const TextStyle(
                                        fontFamily: "Slussen",
                                        fontWeight: FontWeight.w800,
                                        fontSize: 16,
                                        color: Color(0xFFFFFFFF)
                                      )),
                        Text(sub??'', style: const TextStyle(
                                        fontFamily: "Slussen",
                                        fontWeight: FontWeight.w500,
                                        fontSize: 8,
                                        color: Color(0xFFFFFFFF)
                                      ))
                      ],  
                    ),
                  )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(amount??'', style: TextStyle(
                                      fontFamily: "Slussen",
                                      fontWeight: FontWeight.w800,
                                      fontSize: 16,
                                      color: success??false ? const Color(0xFF2EBB17) : const Color(0xFFFF5361)
                                    )),
                      Text(status??'', style: const TextStyle(
                                      fontFamily: "Slussen",
                                      fontWeight: FontWeight.w500,
                                      fontSize: 8,
                                      color: Color(0xFFFFFFFF)
                                    ))
                    ],
                  )
            
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
