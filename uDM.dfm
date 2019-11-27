object DM: TDM
  OldCreateOrder = False
  Height = 348
  Width = 537
  object Conn: TFDConnection
    Params.Strings = (
      
        'Database=C:\Users\User\Documents\Blangkon\Aplikasi\Clone\Win64\R' +
        'elease\dbForex.db'
      'DriverID=SQLite')
    LoginPrompt = False
    BeforeConnect = ConnBeforeConnect
    Left = 16
    Top = 8
  end
  object QTemp1: TFDQuery
    Connection = Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 200
    Left = 16
    Top = 64
  end
  object QTemp2: TFDQuery
    Connection = Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 200
    Left = 72
    Top = 64
  end
  object QTemp3: TFDQuery
    Connection = Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 200
    Left = 120
    Top = 64
  end
  object QTemp4: TFDQuery
    Connection = Conn
    FetchOptions.AssignedValues = [evRowsetSize]
    FetchOptions.RowsetSize = 200
    Left = 176
    Top = 64
  end
  object RClient: TRESTClient
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    BaseURL = 
      'https://www.blangkon.net/_loader_json/WebService/Emas/API/getDat' +
      'a.php?key=hUIY!*DH!Ey928HD892H89@Y79@&act=getADS'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 184
    Top = 232
  end
  object RReq: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Client = RClient
    Params = <>
    Response = RResp
    Timeout = 17000
    SynchronizedEvents = False
    Left = 256
    Top = 232
  end
  object RResp: TRESTResponse
    Left = 328
    Top = 232
  end
  object bgRClient: TRESTClient
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    BaseURL = 
      'https://www.blangkon.net/_loader_json/WebService/Emas/API/getDat' +
      'a.php?key=hUIY!*DH!Ey928HD892H89@Y79@&act=getADS'
    Params = <>
    RaiseExceptionOn500 = False
    Left = 184
    Top = 288
  end
  object bgRReq: TRESTRequest
    Accept = 'application/json;q=0.9,text/plain;q=0.9,text/html'
    AcceptCharset = 'UTF-8'
    Client = bgRClient
    Params = <>
    Response = bgRResp
    Timeout = 20000
    SynchronizedEvents = False
    Left = 256
    Top = 288
  end
  object bgRResp: TRESTResponse
    ContentType = 'text/html'
    Left = 328
    Top = 288
  end
  object img: TImageList
    Source = <
      item
        MultiResBitmap.LoadSize = 0
        MultiResBitmap = <
          item
            Scale = 1.500000000000000000
            Width = 24
            Height = 24
            PNG = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              007E49444154484BED94410E80200C04513FE6CFD49FE9CBD42D4D24462DA570
              30E924CD964B87432138BF66E26A0206EF5C9F929E530306CEB1253ACE2AA437
              47A522333EFC11F370698BEE1B02898A81F38DF52C48463A5DB9718A48026092
              E40840B12457008A241A01504B4AFE22ACEA125B02C2264054F5D1392D08E100
              CFC926086375D2940000000049454E44AE426082}
            FileName = 
              'C:\Users\User\Documents\Blangkon\Aplikasi\Android Forex\Assets\i' +
              'co\fe-arrow-left.png'
          end>
        Name = 'fe-arrow-left'
      end
      item
        MultiResBitmap.LoadSize = 0
        MultiResBitmap = <
          item
            Scale = 1.500000000000000000
            Width = 24
            Height = 24
            PNG = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              007B49444154484BED94410A80301003AB7ECC9FA93FD3976923117B68D9EEB6
              15840E84E025E361D5757EC1C23401C32763928CEC14031BAC3E6AC9C44EB1FB
              4032DF4F6F1F6C1149008A2439026096E40A8049A21100B544BAA21838D91008
              AB117E17084EB71A7D3C4AF1B8E65FB4F9547DFB078C3619EE7C817317FC6D26
              086922A81B0000000049454E44AE426082}
            FileName = 
              'C:\Users\User\Documents\Blangkon\Aplikasi\Android Forex\Assets\i' +
              'co\fe-arrow-right.png'
          end>
        Name = 'fe-arrow-right'
      end
      item
        MultiResBitmap.LoadSize = 0
        MultiResBitmap = <
          item
            Scale = 1.500000000000000000
            Width = 24
            Height = 24
            PNG = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              006949444154484BED8F510A80300C43A717D79BEB020D0499A5B28A087D10FA
              B134E95A51FC97CD14E5911FC6C3145972FDAB4D65B109F62EAF046FF010DD75
              C112AFBAFB895E0E695108AF643A9C8C4AD2C2C9B544351D4E462569E1444BD2
              C309825F0B2F8A4F68ED04B1C931D329A836260000000049454E44AE426082}
            FileName = 
              'C:\Users\User\Documents\Blangkon\Aplikasi\Android Forex\Assets\i' +
              'co\fe-arrow-down.png'
          end>
        Name = 'fe-arrow-down'
      end
      item
        MultiResBitmap.LoadSize = 0
        MultiResBitmap = <
          item
            Scale = 1.500000000000000000
            Width = 24
            Height = 24
            PNG = {
              89504E470D0A1A0A0000000D4948445200000018000000180806000000E0773D
              F8000000017352474200AECE1CE90000000467414D410000B18F0BFC61050000
              006149444154484BED8D010A80201004AF3E6EBD3C3DD88543E42C3588B88145
              109D9120F81F097B05155FD8F288952F8FB4E4DC74A4961F98BD1B8EB4E4643A
              E2C9C970E48E9C74233B4ECB865339CB7A017D43EC5F17FDE8896B9EBE0F82EF
              2092018F5B33D383EF59450000000049454E44AE426082}
            FileName = 
              'C:\Users\User\Documents\Blangkon\Aplikasi\Android Forex\Assets\i' +
              'co\fe-arrow-up.png'
          end>
        Name = 'fe-arrow-up'
      end>
    Destination = <
      item
        Layers = <
          item
            Name = 'fe-arrow-left'
          end>
      end
      item
        Layers = <
          item
            Name = 'fe-arrow-right'
          end>
      end
      item
        Layers = <
          item
            Name = 'fe-arrow-down'
          end>
      end
      item
        Layers = <
          item
            Name = 'fe-arrow-up'
          end>
      end>
    Left = 488
    Top = 24
  end
end
