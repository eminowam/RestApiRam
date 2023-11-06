import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:rest_api_ram/data/models/character.dart';
import 'package:rest_api_ram/data_base/db_helper.dart';
import 'package:rest_api_ram/view/screens/details.dart';
import 'package:rest_api_ram/view/widgets/character_status.dart';

class StorageListTile extends StatelessWidget {
  final Results result;
  final int characterId;
  final bool? isSaved;

  const StorageListTile({
    super.key,
    required this.result,
    required this.characterId,
    this.isSaved});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white10,
              border: Border.all(color: Colors.grey.withOpacity(0.6)),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                    color: Colors.white.withOpacity(1.0),
                    blurRadius: 8,
                    offset: Offset(0, 9))
              ]),
          height: MediaQuery.of(context).size.height / 7,
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailsScreen(
                      result: result,
                      liveState: result.status == "Alive"
                          ? LiveState.alive
                          : result.status == "Dead"
                          ? LiveState.dead
                          : LiveState.unknown,
                    )),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CachedNetworkImage(
                  imageUrl: result.image,
                  placeholder: (
                      context,
                      url,
                      ) =>
                  const CircularProgressIndicator(
                    color: Colors.green,
                  ),
                  errorWidget: (context, url, error) =>
                  const Icon(Icons.error),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 1.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              result.name,
                              overflow: TextOverflow.fade,
                              softWrap: false,
                              maxLines: 1,
                              style: const TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            IconButton(onPressed: () async{
                              await DatabaseHelper.deleteItem(characterId);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Deleted')),);
                            }, icon: const Icon(Icons.close))
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 0,
                      ),
                      CharacterStatus(
                          liveState: result.status == 'Alive'
                              ? LiveState.alive
                              : result.status == 'Dead'
                              ? LiveState.dead
                              : LiveState.unknown),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Species: ",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  result.species,
                                  style: const TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w400),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Gender: ",
                                  style: TextStyle(
                                      fontSize: 13, fontWeight: FontWeight.w400),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  result.gender,
                                  style: const TextStyle(
                                      fontSize: 14, fontWeight: FontWeight.w400),
                                  overflow: TextOverflow.ellipsis,
                                ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
