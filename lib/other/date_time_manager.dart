
class DateTimeManager
{

  String formatTime12Hour(DateTime? dateTime,{bool showDate = false,bool showYear = false,bool time = true}) {
    Map<int,String> months = {
      1:'Jan',
      2:'Feb',
      3:'Mar',
      4:'Apr',
      5:'May',
      6:'Jun',
      7:'Jul',
      8:'Aug',
      9:'Sep',
      10:'Oct',
      11:'Nov',
      12:'Dec',
    };
    if (dateTime == null) return '';

    int hour = dateTime.hour;
    int minute = dateTime.minute;

    String period = hour >= 12 ? 'PM' : 'AM';

    hour = hour % 12;
    hour = hour == 0 ? 12 : hour;

    String formattedMinute = minute.toString().padLeft(2, '0');

    return '${showDate? '${months[dateTime.month]} ${dateTime.day}${showYear?'':','} ': ''} ${showYear? '${dateTime.year}${showDate?'':', '}': ''}${time? '$hour:$formattedMinute $period': ''}';
  }


  String timeAgo(DateTime? dateTime) {
    if (dateTime == null) return '';

    final now = DateTime.now();
    final diff = now.difference(dateTime.toLocal());

    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes} minute${diff.inMinutes == 1 ? '' : 's'} ago';
    if (diff.inHours < 24) return '${diff.inHours} hour${diff.inHours == 1 ? '' : 's'} ago';
    if (diff.inDays == 1) return 'yesterday';
    if (diff.inDays < 7) return '${diff.inDays} day${diff.inDays == 1 ? '' : 's'} ago';
    if (diff.inDays < 30) return '${(diff.inDays / 7).floor()} week${(diff.inDays / 7).floor() == 1 ? '' : 's'} ago';
    if (diff.inDays < 365) return '${(diff.inDays / 30).floor()} month${(diff.inDays / 30).floor() == 1 ? '' : 's'} ago';

    return '${(diff.inDays / 365).floor()} year${(diff.inDays / 365).floor() == 1 ? '' : 's'} ago';
  }


}