import 'package:flutter/material.dart';

class FakeDb{


  static List<Map> homeStory()
  {
    return [
      {
        'Image':'assets/static/story/Avatar (1).png',
        'name':'Priya',
      },

      {
        'Image':'assets/static/story/Avatar (2).png',
        'name':'Roshni',
      },

      {
        'Image':'assets/static/story/Avatar (3).png',
        'name':'Rick',
      },

      {
        'Image':'assets/static/story/Avatar (4).png',
        'name':'Nick',
      },

      {
        'Image':'assets/static/story/b9e31cb8fccaec92f14704df828cee09e0e57975.jpg',
        'name':'Roshni',
      },
    ];
  }



  static List<Map> onlineUser()
  {

    List<Map<String, dynamic>> onlineUsers = [
      {
        'name': 'Rick',
        'age': '25 yrs',
        'gender': 'Female',
        'ratting': 3.4,
        'Experience': '1k+ hrs',
        'about': 'I became insomniac after losing my best friend and my dog.',
        'image': 'https://randomuser.me/api/portraits/women/44.jpg',
      },
      {
        'name': 'Maya',
        'age': '22 yrs',
        'gender': 'Female',
        'ratting': 4.8,
        'Experience': '800+ hrs',
        'about': 'I love late night talks and deep conversations.',
        'image': 'https://randomuser.me/api/portraits/women/65.jpg',
      },
      {
        'name': 'Jay',
        'age': '27 yrs',
        'gender': 'Male',
        'ratting': 4.2,
        'Experience': '2k+ hrs',
        'about': 'Night owl who enjoys gaming and chatting.',
        'image': 'https://randomuser.me/api/portraits/men/32.jpg',
      },
      {
        'name': 'Tina',
        'age': '24 yrs',
        'gender': 'Female',
        'ratting': 3.9,
        'Experience': '1.5k+ hrs',
        'about': 'Just someone who understands silence more than words.',
        'image': 'https://randomuser.me/api/portraits/women/12.jpg',
      },
      {
        'name': 'Leo',
        'age': '30 yrs',
        'gender': 'Male',
        'ratting': 4.5,
        'Experience': '3k+ hrs',
        'about': 'Let’s talk about life, space, or your favorite song.',
        'image': 'https://randomuser.me/api/portraits/men/45.jpg',
      },
      {
        'name': 'Aanya',
        'age': '21 yrs',
        'gender': 'Female',
        'ratting': 3.7,
        'Experience': '900+ hrs',
        'about': 'Here to listen and help you unwind your mind.',
        'image': 'https://randomuser.me/api/portraits/women/21.jpg',
      },
      {
        'name': 'Kabir',
        'age': '26 yrs',
        'gender': 'Male',
        'ratting': 4.1,
        'Experience': '1.2k+ hrs',
        'about': 'I’m a night therapist in disguise.',
        'image': 'https://randomuser.me/api/portraits/men/28.jpg',
      },
      {
        'name': 'Sara',
        'age': '23 yrs',
        'gender': 'Female',
        'ratting': 4.0,
        'Experience': '1k+ hrs',
        'about': 'Sometimes all we need is someone to talk to.',
        'image': 'https://randomuser.me/api/portraits/women/36.jpg',
      },
      {
        'name': 'Rhea',
        'age': '28 yrs',
        'gender': 'Female',
        'ratting': 4.6,
        'Experience': '2.5k+ hrs',
        'about': 'Music, stars, and late night talks – that’s me.',
        'image': 'https://randomuser.me/api/portraits/women/77.jpg',
      },
      {
        'name': 'Aditya',
        'age': '29 yrs',
        'gender': 'Male',
        'ratting': 3.8,
        'Experience': '1.8k+ hrs',
        'about': 'A great listener with a calm voice.',
        'image': 'https://randomuser.me/api/portraits/men/66.jpg',
      },
    ];



    return onlineUsers;

  }


  static List<Map> transiction()
  {

    List<Map<String, String>> transactions = [
      {
        'name': 'Roshni',
        'date': 'March 20, 2025 02:45 PM',
        'amount': '-\$45',
        'image': 'https://randomuser.me/api/portraits/women/11.jpg',
      },
      {
        'name': 'Aman',
        'date': 'April 12, 2025 10:15 AM',
        'amount': '+\$200',
        'image': 'https://randomuser.me/api/portraits/men/22.jpg',
      },
      {
        'name': 'Sneha',
        'date': 'March 18, 2025 06:30 PM',
        'amount': '-\$90',
        'image': 'https://randomuser.me/api/portraits/women/33.jpg',
      },
      {
        'name': 'Karan',
        'date': 'April 01, 2025 01:00 PM',
        'amount': '+\$150',
        'image': 'https://randomuser.me/api/portraits/men/44.jpg',
      },
      {
        'name': 'Neha',
        'date': 'March 22, 2025 03:20 PM',
        'amount': '-\$30',
        'image': 'https://randomuser.me/api/portraits/women/55.jpg',
      },
      {
        'name': 'Ravi',
        'date': 'April 05, 2025 11:45 AM',
        'amount': '+\$100',
        'image': 'https://randomuser.me/api/portraits/men/66.jpg',
      },
      {
        'name': 'Simran',
        'date': 'March 25, 2025 09:10 AM',
        'amount': '-\$50',
        'image': 'https://randomuser.me/api/portraits/women/77.jpg',
      },
      {
        'name': 'Vikram',
        'date': 'April 10, 2025 07:25 PM',
        'amount': '+\$75',
        'image': 'https://randomuser.me/api/portraits/men/88.jpg',
      },
      {
        'name': 'Pooja',
        'date': 'March 30, 2025 04:40 PM',
        'amount': '-\$110',
        'image': 'https://randomuser.me/api/portraits/women/99.jpg',
      },
      {
        'name': 'Arjun',
        'date': 'April 08, 2025 08:05 AM',
        'amount': '+\$85',
        'image': 'https://randomuser.me/api/portraits/men/21.jpg',
      },
    ];


    return transactions;

  }



  static List<Map<String, dynamic>> chatContect()
  {
   final List<Map<String, dynamic>> chatContact = [
      {
        "image": "https://randomuser.me/api/portraits/women/1.jpg",
        "name": "Alice",
        "unreadCount": 3,
        "lastMessage": "Hey, are we still on for today?",
        "lastMessageTime": "10:30 AM",
      },
      {
        "image": "https://randomuser.me/api/portraits/men/2.jpg",
        "name": "Bob",
        "unreadCount": 0,
        "lastMessage": "Thanks for the help!",
        "lastMessageTime": "Yesterday",
      },
      {
        "image": "https://randomuser.me/api/portraits/men/3.jpg",
        "name": "Charlie",
        "unreadCount": 1,
        "lastMessage": "I'll call you back.",
        "lastMessageTime": "9:15 AM",
      },
      {
        "image": "https://randomuser.me/api/portraits/women/4.jpg",
        "name": "Diana",
        "unreadCount": 5,
        "lastMessage": "Can you check this out?",
        "lastMessageTime": "8:42 PM",
      },
      {
        "image": "https://randomuser.me/api/portraits/men/5.jpg",
        "name": "Ethan",
        "unreadCount": 0,
        "lastMessage": "Good night!",
        "lastMessageTime": "Sun",
      },
    ];

   return chatContact;

  }


  static final List<Map<String, dynamic>> callHistory = [
    {
      "image": "https://randomuser.me/api/portraits/women/10.jpg",
      "name": "Sophia",
      "time": "Yesterday, 10:33 PM",
      "callType": "audio",
      "direction": "incoming",
      "status": "completed",
    },
    {
      "image": "https://randomuser.me/api/portraits/men/12.jpg",
      "name": "Liam",
      "time": "Today, 9:12 AM",
      "callType": "video",
      "direction": "outgoing",
      "status": "missed",
    },
    {
      "image": "https://randomuser.me/api/portraits/women/14.jpg",
      "name": "Emma",
      "time": "Monday, 5:47 PM",
      "callType": "audio",
      "direction": "outgoing",
      "status": "completed",
    },
    {
      "image": "https://randomuser.me/api/portraits/men/15.jpg",
      "name": "Noah",
      "time": "Sunday, 2:20 PM",
      "callType": "video",
      "direction": "incoming",
      "status": "missed",
    },
    {
      "image": "https://randomuser.me/api/portraits/women/16.jpg",
      "name": "Olivia",
      "time": "Yesterday, 11:00 AM",
      "callType": "audio",
      "direction": "incoming",
      "status": "completed",
    },
  ];



}