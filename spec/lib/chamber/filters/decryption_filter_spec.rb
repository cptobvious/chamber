require 'rspectacular'
require 'chamber/filters/decryption_filter'

module    Chamber
module    Filters
describe  DecryptionFilter do
  it 'will attempt to decrypt values which are marked as "secure"' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        _secure_my_secure_setting: 'cJbFe0NI5wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4m' \
                                   'psspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ5' \
                                   '7m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfXz' \
                                   'nf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZD' \
                                   'wS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNXW' \
                                   'S7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1kK' \
                                   'TcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ==',
      },
      decryption_key: './spec/spec_key')

    expect(filtered_settings._secure_my_secure_setting).to eql 'hello'
  end

  it 'will not attempt to decrypt values which are not marked as "secure"' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        my_secure_setting: 'cJbFe0NI5wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4m' \
                           'psspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ5' \
                           '7m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfXz' \
                           'nf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZD' \
                           'wS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNXW' \
                           'S7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1kK' \
                           'TcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ==' },
      decryption_key: './spec/spec_key')

    my_secure_setting = filtered_settings.my_secure_setting

    expect(my_secure_setting).to eql 'cJbFe0NI5wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYT' \
                                     'haV4mpsspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJU' \
                                     'd4akun6EZ57m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4L' \
                                     'DGydkEjY1ZprfXznf+rU31YGDJUTf34ESz7fsQGSc9Dj' \
                                     'kBb9ao8Mv4cI7pCXkQZDwS5kLAZDf6agy1GzeL71Z8lr' \
                                     'mQzk8QQuf/1kQzxsWVlzpKNXWS7u2CJ0sN5eINMngJBf' \
                                     'v5ZFrZgfXc86wdgUKc8aaoX8OQA1kKTcdgbE9NcAhNr1' \
                                     '+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ=='
  end

  it 'will not attempt to decrypt values even if they are prefixed with "secure"' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        secure_setting: 'cJbFe0NI5wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4mpsspg/ZTBt' \
                        'mjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ57m+QzCMJYnfY95gB2/em' \
                        'EAQLSz4/YwsE4LDGydkEjY1ZprfXznf+rU31YGDJUTf34ESz7fsQGSc9Djk' \
                        'Bb9ao8Mv4cI7pCXkQZDwS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxs' \
                        'WVlzpKNXWS7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1kKT' \
                        'cdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ==',
      },
      decryption_key: './spec/spec_key')

    secure_setting = filtered_settings.secure_setting

    expect(secure_setting).to eql 'cJbFe0NI5wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4m' \
                                  'psspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ5' \
                                  '7m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfXz' \
                                  'nf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZD' \
                                  'wS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNXW' \
                                  'S7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1kK' \
                                  'TcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ=='
  end

  it 'will not attempt to decrypt values even if they are not properly encoded' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        _secure_my_secure_setting: 'cJbFe0NI5\wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4' \
                                   'mpsspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ' \
                                   '57m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfX' \
                                   'znf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZ' \
                                   'DwS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNX' \
                                   'WS7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1k' \
                                   'KTcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ==',
      },
      decryption_key: './spec/spec_key')

    my_secure_setting = filtered_settings._secure_my_secure_setting

    expect(my_secure_setting).to eql 'cJbFe0NI5\wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4' \
                                     'mpsspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ' \
                                     '57m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfX' \
                                     'znf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZ' \
                                     'DwS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNX' \
                                     'WS7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1k' \
                                     'KTcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ=='
  end

  it 'will not attempt to decrypt values if it guesses that they are not encrpyted' do
    filtered_settings = DecryptionFilter.execute(data:           {
                                                   _secure_my_secure_setting: 'hello' },
                                                 decryption_key: './spec/spec_key')

    expect(filtered_settings._secure_my_secure_setting).to eql 'hello'
  end

  it 'simply returns the encrypted string if there is no decryption key' do
    filtered_settings = DecryptionFilter.execute(
      data: {
        _secure_my_secure_setting: 'cJbFe0NI5\wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4' \
                                   'mpsspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ' \
                                   '57m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfX' \
                                   'znf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZ' \
                                   'DwS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNX' \
                                   'WS7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1k' \
                                   'KTcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ==',
      },
    )

    my_secure_setting = filtered_settings._secure_my_secure_setting

    expect(my_secure_setting).to eql 'cJbFe0NI5\wknmsp2fVgpC/YeBD2pvcdVD+p0pUdnMoYThaV4' \
                                     'mpsspg/ZTBtmjx7kMwcF6cjXFLDVw3FxptTHwzJUd4akun6EZ' \
                                     '57m+QzCMJYnfY95gB2/emEAQLSz4/YwsE4LDGydkEjY1ZprfX' \
                                     'znf+rU31YGDJUTf34ESz7fsQGSc9DjkBb9ao8Mv4cI7pCXkQZ' \
                                     'DwS5kLAZDf6agy1GzeL71Z8lrmQzk8QQuf/1kQzxsWVlzpKNX' \
                                     'WS7u2CJ0sN5eINMngJBfv5ZFrZgfXc86wdgUKc8aaoX8OQA1k' \
                                     'KTcdgbE9NcAhNr1+WfNxMnz84XzmUp2Y0H1jPgGkBKQJKArfQ=='
  end

  it 'can decrypt a complex object' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        _secure_my_secure_setting: 'rF1MIcLX/Q88gjpHTifI27fJHopDKVTJRvOwF2MZ8kVIrvBhFg' \
                                   'LOyQ7JEBiWNBh1yUtR6PeKlB+h44sIL3yKMcZyccX73Mo+CiWx' \
                                   'mnjtK4I1QxcJL8OSLa8GQPlSBxoBCykWqerwN0b2oS/jv8umB2' \
                                   'j2RyANFYklD3mAxn1LsoTuFPAif+SCLRIGafcHkOywM32qn6Hh' \
                                   'UpeBChX81JhJpip1gdJmRTGEZjKfR93h1shW0LqLLbdQUwYPOP' \
                                   'bnjz7fU7x+d5/ighWTDsmOVyvEiqM0WasFzK+WBUfvo8tQxUym' \
                                   'exw/U3B7N/0R/9v6U3l6x7eeIoQ4+lnJK2ULFzVgiw==',
      },
      decryption_key: './spec/spec_key')

    expect(filtered_settings._secure_my_secure_setting).to be_a Integer
    expect(filtered_settings._secure_my_secure_setting).to eql  12_345
  end

  it 'can decrypt a number that has not been yamlled' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        _secure_my_secure_setting: 'Ieh5poOpcirj1jihkh1eENaCrF8ECQSLOigM4ApTZ8hp4vrL3N' \
                                   'KWp3djEkQz0QceopgN8TBJOEj1lqfGGL3Ar5L0SGrIsHt6KOil' \
                                   'erEXXH4/e2+s8JFWpdfjCxgn12fv1jqXxNyuMUlYRBD7R+oRNV' \
                                   'A5nNpnwiSE7IOBjUEZyzlQUrePVku5CtOs0hfGe+79n6D8zFGT' \
                                   'px7UjZg4QVXyHISBM2hAaDOZ0dfxVqbzmvN3B68xbuIty5vyv1' \
                                   '+Ry2k+yIGJXIOjNm96ntDxIuUbycfrqYdtopBDI5kcr0zckPWM' \
                                   'QRqkp7yd/XNZqyYCFGMNKNwokE6wZuGffkD/H/VPxQ==',
      },
      decryption_key: './spec/spec_key')

    expect(filtered_settings._secure_my_secure_setting).to eql '12345'
  end

  it 'can decrypt a string that has not been yamlled' do
    filtered_settings = DecryptionFilter.execute(
      data:           {
        _secure_my_secure_setting: 'V2ifd6KwfGK8zW7K87ypHiA89UvVqsAX3961dR/B5ensruVFi5' \
                                   'KydFR1KxPQHxInhVl4GIvpBCwczK1mMZ61NGVISK04tg90R52/' \
                                   'ue0s4V9v01h1wTnahrkRGFyKk4iiQwsluuXGaW4gBFayaKOs77' \
                                   'HL/fMBY985akz8lv/8secg2U66YWeIHblJ2OKdNELaEFZKXWyw' \
                                   'PxXEMPckAnbJB6liwFNjbY1y0WH6oiP/OzoiOGzGeuUr2P8IfW' \
                                   '8JIedOuy4JV4Y46QPvu4zCZhDgNa4dTCdOTA/oEd5+GLhuoSiC' \
                                   '87k/vbURwhqs1fmyXUJpUaDg3x4quTDZ6uBTG0Qu/A==',
      },
      decryption_key: './spec/spec_key')

    expect(filtered_settings._secure_my_secure_setting).to eql 'hello'
  end
end
end
end
